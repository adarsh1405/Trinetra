from flask import Flask, jsonify, request, send_from_directory, render_template
from flask_restful import Resource, Api
from flask_cors import CORS
from flask_pymongo import PyMongo
from werkzeug.security import generate_password_hash, check_password_hash
import uuid
import os
import datetime
import jwt
import re
import requests
import json
from dotenv import load_dotenv

load_dotenv()


app = Flask(__name__)
timezone = datetime.timezone(datetime.timedelta(
    seconds=-19800), 'India Standard Time')
# timezone = datetime.timezone.utc


class LoginView(Resource):

    def get(self):
        return jsonify(
            {
                "success": False,
                "message": "Method Not Allowed"
            })

    def post(self):
        data = request.get_json()
        if not data:
            return not_found("Some fields are missing.")
        phone = data.get('phone') or data.get('username')
        password = data.get('imei') or data.get('password')
        if phone and password:
            user = users.find_one({'phone': phone})
            if user:
                password_hash = user.get("password", "")
                if (not check_password_hash(password_hash, password)
                        and password_hash):
                    return jsonify(
                        {
                            'success': False,
                            'token': None,
                            'message': "Invalid Password"
                        })
                response = {
                    'success': True,
                    "first_run": False,
                    'token': encode_auth_token(phone, user.get("is_admin"))}
                if not password_hash:
                    response.update({"first_run": True})
                return jsonify(response)
            else:
                return jsonify(
                    {
                        'success': False,
                        'token': None,
                        'message': "No such user exists"
                    })
        else:
            return not_found("Some fields are missing.")


class UserView(Resource):

    def get(self):
        auth_header = request.headers.get('Authorization')
        if auth_header:
            auth_token = auth_header.split(" ")[1]
        else:
            return not_found("Missing Authorization Token")
        resp = decode_auth_token(auth_token)
        if isinstance(resp, str):
            return not_found(resp)
        if resp["admin"]:
            user_list = users.find({"is_admin": False})
            profile_list = []
            for user in user_list:
                user.pop("password", None)
                user.pop("_id", None)
                user = json.loads(json.dumps(user, default=iso_convert))
                profile_list.append(user)
            return jsonify(
                {
                    "success": True,
                    "count": user_list.retrieved,
                    "users": profile_list
                })
        else:
            return not_found("Unauthorized User")

    def post(self):
        auth_header = request.headers.get('Authorization')
        if auth_header:
            auth_token = auth_header.split(" ")[1]
        else:
            return not_found("Missing Authorization Token")
        resp = decode_auth_token(auth_token)
        if isinstance(resp, str):
            return not_found(resp)
        if not resp["admin"]:
            return not_found("Unauthorized User")
        data = request.form
        if not data:
            return not_found("Some fields are missing.")
        employee_id = data.get('employee_id')
        name = data.get('name')
        phone = data.get('phone')
        photo = request.files.get('photo')
        if all([employee_id, name, phone, photo]):
            photo_name = str(uuid.uuid4())+"." + \
                photo.filename.split('.')[-1]
            photo.save(os.path.join("uploads", photo_name))
            photo_name = "/uploads/"+photo_name
            now = datetime.datetime.now(timezone)
            users.update_one(
                {
                    'employee_id': employee_id,
                    "phone": phone
                },
                {
                    '$set': {
                        "employee_id": employee_id,
                        "name": name,
                        "phone": phone,
                        "photo": photo_name,
                        "is_admin": False,
                        "overall": {
                            "present": 0,
                            "total": 0
                        },
                        "current": {
                            "timestamp": now,
                            "logs": []
                        },
                        "fcm":""
                    }
                }, upsert=True)
            attendance.update_one(
                {'phone': phone},
                {
                    '$set': {
                        'phone': phone,
                        'logs': []
                    }
                }, upsert=True)
            user = users.find_one({'employee_id': employee_id})
            user.pop("password", None)
            user.pop("_id", None)
            user.update({"status": True})
            return app.response_class(
                response=json.dumps(user, default=iso_convert),
                status=200,
                mimetype='application/json'
            )
            # return jsonify({'success': True, **user})
        else:
            return not_found("Some fields are missing.")


class PasswordView(Resource):

    def get(self):
        return jsonify(
            {
                "success": False,
                "message": "Method Not Allowed"
            })

    def post(self):
        auth_header = request.headers.get('Authorization')
        if auth_header:
            auth_token = auth_header.split(" ")[1]
        else:
            return not_found("Missing Authorization Token")
        resp = decode_auth_token(auth_token)
        if isinstance(resp, str):
            return not_found(resp)
        data = request.get_json()
        if not data:
            return not_found("Missing IMEI Field")
        phone = resp['id']
        password = data.get('imei')
        firebase_token = data.get('fcm')
        if password and firebase_token:
            user = users.find_one({'phone': phone})
            if user.get("password") is None:
                users.update_one(
                    {'phone': phone},
                    {
                        '$set':
                        {
                            "password": generate_password_hash(password),
                            "fcm": firebase_token
                        }
                    })
                return jsonify({'success': True})
            else:
                return jsonify(
                    {
                        'success': False,
                        "message": "IMEI already registered."
                    })
        else:
            return not_found("Some fields are missing.")


class ProfileView(Resource):

    def get(self):
        auth_header = request.headers.get('Authorization')
        if auth_header:
            auth_token = auth_header.split(" ")[1]
        else:
            return not_found("Missing Authorization Token")
        resp = decode_auth_token(auth_token)
        if isinstance(resp, str):
            return not_found(resp)
        user = users.find_one({'phone': resp['id']})
        user.pop("password", None)
        user.pop("_id", None)
        user.update({"status": True})
        return app.response_class(
            response=json.dumps(user, default=iso_convert),
            status=200,
            mimetype='application/json'
        )
        # return jsonify(
        #     {
        #         "success": True,
        #         **json.loads(json.dumps(user, default=iso_convert))
        #     })

    def update(self,user,log):
        prev_logs = user["current"].get("logs", [])
        # print("PREV: ", prev_logs)
        # print("LOGS: ", len(prev_logs))
        if len(prev_logs) < 5:
            users.update_one(
                {'phone': user['phone']},
                {
                    '$push': {"current.logs": log},
                    '$set': {"active": 1}
                })
        else:
            p_count = int(all([prev_log["available"]
                                for prev_log in prev_logs]))
            overall = user["overall"]
            users.update_one(
                {'phone': user['phone']},
                {
                    '$set': {
                        "overall.total": overall.get("total", 0)+1,
                        "overall.present": overall.get("present")+p_count,
                        "current.logs": [log],
                        "current.timestamp": log["timestamp"],
                        "active": 1
                    }
                })
        attendance.update_one(
            {"phone": user['phone']},
            {
                '$push': {"logs": log}
            })

    def post(self):
        auth_header = request.headers.get('Authorization')
        if auth_header:
            auth_token = auth_header.split(" ")[1]
        else:
            return not_found("Missing Authorization Token")
        resp = decode_auth_token(auth_token)
        if isinstance(resp, str):
            return not_found(resp)
        user = users.find_one({'phone': resp['id']})
        if not user:
            return not_found("No such user exists")
        data = request.get_json()
        if not data:
            return not_found("Some fields are missing.")
        lat = data.get("lat")
        lon = data.get("lon")
        if lat and lon:
            now = datetime.datetime.now(timezone)
            # datef = '%Y-%m-%d %H:%M:%S'
            # now_str = now.strftime(datef)
            location = coords_collection.find_one({"id": "test"})
            if not location:
                return not_found("Location has not been set")
            if user.get("active", 1):
                return not_found("Attendance has not been requested yet")
            poly_map = MapPolygon(location.pop("location"))
            available = poly_map.validate_point(Point(lon, lat))
            log = {"timestamp": now, "lat": lat,
                   "lon": lon, "available": available}
            # timediff = datetime.datetime.strptime(
            #     now_str, datef)-user["current"].get("timestamp")
            # if (timediff < datetime.timedelta(hours=21)):
            self.update(user,log)
            return jsonify({"success": True, "available": available})
        else:
            return not_found("Some fields are missing.")


class AdminRegisterView(Resource):

    def get(self):
        return jsonify(
            {
                "success": False,
                "message": "Method Not Allowed"
            })

    def post(self):
        data = request.get_json()
        if not data:
            return not_found("Some fields are missing.")
        username = data.get('username')
        password = data.get('password')
        if username and password:
            users.update_one(
                {"phone": username},
                {
                    "$set": {
                        'employee_id': None,
                        "phone": username,
                        "password": generate_password_hash(password),
                        "is_admin": True
                    }
                }, upsert=True)
            user = users.find_one({'phone': username})
            user.pop("password", None)
            user.pop("_id", None)
            user.update({"status": True})
            return app.response_class(
                response=json.dumps(user, default=iso_convert),
                status=200,
                mimetype='application/json'
            )
            # return jsonify({'success': True, **user})
        else:
            return not_found("Some fields are missing.")


class DetailUserView(Resource):

    def get(self, userId):
        auth_header = request.headers.get('Authorization')
        if auth_header:
            auth_token = auth_header.split(" ")[1]
        else:
            return not_found("Missing Authorization Token")
        resp = decode_auth_token(auth_token)
        if isinstance(resp, str):
            return not_found(resp)
        if resp["admin"] or userId == resp["id"]:
            user = attendance.find_one({"phone": userId})
            if user:
                return jsonify(
                    {
                        "success": True,
                        "attendance": json.loads(
                            json.dumps(user.pop("logs", []),
                                       default=iso_convert))
                    })
            else:
                return not_found("No Such User Exists")
        else:
            return not_found("Unauthorized User")

    def post(self, userId):
        return jsonify(
            {
                "success": False,
                "message": "Method Not Allowed"
            })


class GeoView(Resource):

    def get(self):
        # auth_header = request.headers.get('Authorization')
        # if auth_header:
        #     auth_token = auth_header.split(" ")[1]
        # else:
        #     return not_found("Missing Authorization Token")
        # resp = decode_auth_token(auth_token)
        # if isinstance(resp, str):
        #     return not_found(resp)
        # if resp["admin"]:
        location = coords_collection.find_one({"id": "test"})
        if location:
            location.pop("_id")
            return jsonify({"success": True, **location})
        return not_found("Location has not been set")
        # else:
        #     return not_found("Unauthorized User")

    def post(self):
        auth_header = request.headers.get('Authorization')
        if auth_header:
            auth_token = auth_header.split(" ")[1]
        else:
            return not_found("Missing Authorization Token")
        resp = decode_auth_token(auth_token)
        if isinstance(resp, str):
            return not_found(resp)
        data = request.get_json()
        if not data:
            return not_found("Some fields are missing.")
        place_name = data.get('name') or "Test Area"
        geo_data = data.get('geodata')
        if not (place_name and geo_data):
            return not_found("Some fields are missing.")
        if resp["admin"]:
            coords_collection.update_one(
                {
                    "id": "test"
                },
                {
                    '$set': {
                        'place': place_name,
                        'location': Point.coords_serializer(geo_data)
                    }
                }, upsert=True)
            location = coords_collection.find_one({"id": "test"})
            if location:
                location.pop("_id")
                return jsonify({"success": True, **location})
            return not_found("Some Error Occcured")
        else:
            return not_found("Unauthorized User")


class Point:

    def __init__(self, x=0, y=0):
        self.x = float(x)
        self.y = float(y)

    @staticmethod
    def coords_serializer(coords):
        response = []
        for coord in coords:
            response.append(dict(lon=coord[0], lat=coord[1]))
        return response

    @staticmethod
    def coords_deserializer(coords):
        points = []
        for coord in coords:
            points.append(Point(coord["lon"], coord["lat"]))
        return points


class MapPolygon:

    def __init__(self, coordinates):
        self.points = Point.coords_deserializer(coordinates)

    def validate_point(self, point):
        p = point
        p1 = self.points[0]
        counter = 0
        N = len(self.points)
        for i in range(N+1):
            p2 = self.points[i % N]
            if (p.y > min(p1.y, p2.y)):
                if(p.y <= max(p1.y, p2.y)):
                    if(p.x <= max(p1.x, p2.x)):
                        if(p1.y != p2.y):
                            xint = (p.y-p1.y)*(p2.x-p1.x)/(p2.y-p1.y)+p1.x
                            if (p1.x == p2.x or p.x <= xint):
                                counter += 1
            p1 = p2
        return counter % 2 != 0


class MapView:

    def __init__(self, location):
        self.location = location

    def location_coords(self):
        res = requests.get(
            "https://www.google.com/maps/search/{}/".format(
                self.location)).text
        pattern = (r"https://maps\.google\.com/maps/api/staticmap"
                   r"\?center=(.+?)&amp;zoom=(\d+)")
        match = re.search(pattern, res)
        self.lat, self.lon = map(float, match.group(1).split('%2C'))
        self.zoom = int(match.group(2))

        return dict(lat=self.lat, lon=self.lon, zoom=self.zoom)


@app.route("/admin/map", methods=["GET", "POST", "PUT"])
def mapView():
    # auth_header = request.headers.get('Authorization')
    # if auth_header:
    #     auth_token = auth_header.split(" ")[1]
    # else:
    #     return not_found("Missing Authorization Token")
    # resp = decode_auth_token(auth_token)
    # if isinstance(resp, str):
    #     return not_found(resp)
    # if resp["admin"]:
    #     location = coords_collection.find_one({"id": "test"})
    #     if location:
    #         location.pop("_id")
    #         return jsonify({"success": True, **location})
    #     return not_found("Location has not been set")
    # else:
    #     return not_found("Unauthorized User")
    if request.method == 'GET':
        return render_template("mapbox.html")
    elif request.method == 'POST':
        coords = MapView(request.get_json().get("location")).location_coords()
        return jsonify(coords)
    else:
        geo_data = request.get_json().get("geoData")
        if not geo_data:
            return not_found("Missing Coordinates")
        fgeo_data = Point.coords_serializer(geo_data[0])
        coords_collection.update_one(
            {
                "id": "test"
            },
            {
                '$set': {
                    'location': fgeo_data
                }
            }, upsert=True)
        return jsonify(
            {"status": True, "message": "The location data is updated"})


def iso_convert(date):
    if isinstance(date, datetime.datetime):
        return date.replace(tzinfo=timezone).isoformat()


@app.route("/uploads/<filename>")
def uploaded_file(filename):
    return send_from_directory("uploads", filename, as_attachment=True)


@app.errorhandler(404)
def not_found(error=None):
    message = {
        'success': False,
        'message': str(error)
    }
    return jsonify(message)


def decode_auth_token(auth_token):
    """
    Decodes the auth token
    :param auth_token:
    :return: integer|string
    """
    try:
        payload = jwt.decode(
            auth_token,
            app.config.get('SECRET_KEY'),
            algorithm='HS256')
        return payload
    except jwt.ExpiredSignatureError:
        return 'Signature expired. Please log in again.'
    except jwt.InvalidTokenError:
        return 'Invalid token. Please log in again.'


def encode_auth_token(user_id, is_admin=False):
    """
    Generates the Auth Token
    :return: string
    """
    try:
        now = datetime.datetime.utcnow()
        payload = {
            'exp': now + datetime.timedelta(days=1),
            'iat': now,
            'id': user_id,
            'admin': is_admin
        }
        return jwt.encode(
            payload,
            app.config.get('SECRET_KEY'),
            algorithm='HS256'
        ).decode()
    except Exception as e:
        return e


app.config['MONGODB_NAME'] = os.getenv('MONGODB_NAME')
app.config['MONGO_URI'] = os.getenv('MONGO_URI')
app.config['SECRET_KEY'] = os.getenv('SECRET_KEY')

cors = CORS(app)
mongo = PyMongo(app)
users = mongo.db.users
attendance = mongo.db.attendance
coords_collection = mongo.db.coordinates

restServer = Api(app)

restServer.add_resource(LoginView, "/login")
restServer.add_resource(UserView, "/register", '/user')
restServer.add_resource(PasswordView, "/setIMEI")
restServer.add_resource(ProfileView, "/profile")
restServer.add_resource(AdminRegisterView, "/admin/register")
restServer.add_resource(DetailUserView, "/user/<string:userId>")
restServer.add_resource(GeoView, "/admin/location")
# restServer.add_resource(MapBoxView, "/admin/location")
# restServer.add_resource(TaskById, "/api/v1/task/<string:taskId>")


if __name__ == "__main__":
    app.run(host="0.0.0.0", threaded=True, port=5000)
