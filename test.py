import requests
r = requests.post("localhost:5000/user", data={'username': 'alexusher', 'name': 'alex usher', 'email': 'awu19@ic.ac.uk', 'password': 'password'})
print(r.status_code, r.reason)