from flask import Flask, request, render_template
from recognize import Detector
import config
import spoonacular as sp
import random
import numpy as np

app = Flask(__name__)
spoonacular_api = sp.API(config.spoonacular_key)
jokes = [spoonacular_api.get_a_random_food_joke().json()['text'] for i in range(5)]
detector = Detector()

@app.route('/')
def homepage():
    return render_template('index.html') #return homepage on pythonanywhere.com

@app.route('/detection', methods = ['POST'])
def detectObjectsInImage():
    filestream = request.files['image'].read() #Filestream ermöglicht Bearbeitung ohne Zwischenspeichern des Bildes
    nparr = np.fromstring(filestream, np.uint8)
    return detector.detectByImage(nparr)

@app.route('/joke')
def getFoodJoke():
    return {'joke': jokes[random.randint(0, len(jokes) - 1)] if len(jokes) != 0 else "There is no joke today :("}

@app.route('/recipe/<string:ingredients>')
def searchRecipes(ingredients : str):
    return {'recipes' : spoonacular_api.search_recipes_by_ingredients(
        ingredients = ingredients,
        number = 10,
        limitLicense = False,
        ranking = 1
    ).json()}
