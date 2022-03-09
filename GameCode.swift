import Foundation
let ball = OvalShape(width: 40, height: 40)
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

let targetPoints = [
    Point(x:10, y:0),
    Point(x:0, y:10),
    Point(x:10, y:20),
    Point(x:20, y:10)
]

let target = PolygonShape(points: targetPoints)
/*
The setup() function is called once when the app launches. Without it, your app won't compile.
Use it to set up and start your app.

You can create as many other functions as you want, and declare variables and constants,
at the top level of the file (outside any function). You can't write any other kind of code,
for example if statements and for loops, at the top level; they have to be written inside
of a function.
*/

fileprivate func setupBall() {
    
    ball.position = Point(x: 250, y: 400)
    ball.hasPhysics = true
    ball.fillColor = .blue
    //This will add the object to the screen
    scene.add(ball)
}

fileprivate func setupBarrier() {
    
    barrier.position = Point(x: 200, y: 150)
    barrier.hasPhysics = true
    barrier.isImmobile = true
    barrier.fillColor = .yellow
    scene.add(barrier)
}

fileprivate func setupFunnel() {
    //can do a calculation as a variable for Point
    funnel.position = Point(x: 200, y: scene.height - 25)
    //started as black but I wanted to actually set the color
    funnel.fillColor = .black
    scene.add(funnel)
}

fileprivate func setupTarget() {
    target.position = Point(x: 200, y: 400)
    target.hasPhysics = true
    target.isImmobile = true
    target.isImpermeable = false
    target.fillColor = .red
    
    scene.add(target)
}

func setup() {
    // Add circle to scene
    setupBall()
    // Add barrier to scene
    setupBarrier()
    //Add funnel to scene
    setupFunnel()
    
    //adding a target
    setupTarget()
    
    //page 229 on how you are able to call the dropBall function without the ()
    funnel.onTapped = dropBall
}

func dropBall(){
    ball.position = funnel.position
}
