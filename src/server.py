import argparse
import os
import uuid
from flask import Flask, request, flash, redirect, jsonify, send_from_directory

parser = argparse.ArgumentParser(description='Image server')
parser.add_argument('-d', "--host", help="Host ip", default="0.0.0.0")
parser.add_argument('-p', "--port", help="Port number", type=int, default=80)
parser.add_argument('-o', "--output", help="Ouput folder", default="output")
parser.add_argument("--debug", help="Debug mode", action="store_true", default=False)
args = parser.parse_args()

app = Flask(__name__)

app.config['UPLOAD_FOLDER'] = os.path.join(os.getcwd(), args.output)
app.secret_key = 'super secret key'

if not os.path.exists(app.config["UPLOAD_FOLDER"]):
    os.makedirs(app.config["UPLOAD_FOLDER"])


@app.route("/uploadImage", methods=['POST'])
def upload_image():
    filename = str(uuid.uuid4()) + ".jpg"
    if 'file' not in request.files:
        flash('No file part')
        return redirect(request.url)
    file = request.files['file']
    file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
    return jsonify(url=request.url_root + "downloadImage?filename=" + filename)


@app.route("/downloadImage", methods=["GET"])
def download_image():
    filename = request.args.get("filename")
    return send_from_directory(directory=app.config["UPLOAD_FOLDER"], filename=filename, as_attachment=True)


if __name__ == '__main__':
    app.run(args.host, args.port, debug=args.debug)
