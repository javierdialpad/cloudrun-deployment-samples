from flask import Flask

app = Flask(__name__)

# Force build

@app.route("/")
def hello_world():
  return "Hello world!"


if __name__ == "__main__":
  app.run(debug=True, host="0.0.0.0", port=8080)
