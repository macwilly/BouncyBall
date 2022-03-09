import Foundation
let circle = OvalShape(width: 150, height: 150)
let barrierWidth = 300.0
let barrierHeight = 25.0
let barrierPoints = [
    Point(x:0, y:0),
    Point(x: 0, y: barrierHeight),
    Point(x: barrierWidth, y: barrierHeight),
    Point(x: barrierWidth, y: 0)
]
//PolygonShape takes an array op points to draw the object
let barrier = PolygonShape(points: barrierPoints)

let funnelPoints = [
    Point(x:0, y:50),
    Point(x:80, y:50),
    Point(x:60, y:0),
    Point(x:20, y:0)
]

let funnel = PolygonShape(points: funnelPoints)
/*
The setup() function is called once when the app launches. Without it, your app won't compile.
Use it to set up and start your app.

You can create as many other functions as you want, and declare variables and constants,
at the top level of the file (outside any function). You can't write any other kind of code,
for example if statements and for loops, at the top level; they have to be written inside
of a function.
*/

func setup() {
    circle.position = Point(x: 250, y: 400)
    circle.hasPhysics = true
    //This will add the object to the screen
    scene.add(circle)
    
    barrier.position = Point(x: 200, y: 150)
    barrier.hasPhysics = true
    barrier.isImmobile = true
    scene.add(barrier)
    
    //can do a calculation as a variable for Point
    funnel.position = Point(x: 200, y: scene.height - 25)
    scene.add(funnel)
    
    //page 229 on how you are able to call the dropBall function without the ()
    funnel.onTapped = dropBall
}

func dropBall(){
    circle.position = funnel.position
}
