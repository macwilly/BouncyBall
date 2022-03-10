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
    ball.isDraggable = false
    ball.bounciness = 0.6
    scene.trackShape(ball)
    ball.onCollision = ballCollided(with:)
    ball.onExitedScene = ballExitedScene
    ball.onTapped = resetGame
    //This will add the object to the screen
    scene.add(ball)
}

fileprivate func setupBarrier() {
    
    barrier.position = Point(x: 200, y: 150)
    barrier.hasPhysics = true
    barrier.isImmobile = true
    barrier.fillColor = .yellow
    barrier.angle = 0.1
    scene.add(barrier)
}

fileprivate func setupFunnel() {
    //can do a calculation as a variable for Point
    funnel.position = Point(x: 200, y: scene.height - 25)
    //started as black but I wanted to actually set the color
    funnel.fillColor = .black
    funnel.isDraggable = false
    scene.add(funnel)
    //page 229 on how you are able to call the dropBall function without the ()
    funnel.onTapped = dropBall
}

fileprivate func setupTarget() {
    target.position = Point(x: 200, y: 400)
    target.hasPhysics = true
    target.isImmobile = true
    target.isImpermeable = false
    target.isDraggable = false
    target.fillColor = .red
    target.name = "target"
    scene.add(target)
}

// Handles collisions between the ball and the targets.
func ballCollided(with otherShape: Shape){
    if otherShape.name != "target" { return }
    otherShape.fillColor = .green
}

func dropBall(){
    ball.position = funnel.position
    ball.stopAllMotion()
    barrier.isDraggable = false
}


func ballExitedScene() {
    barrier.isDraggable = true
}

func resetGame() {
    barrier.isDraggable = true
    ball.position = Point(x: 0, y: -80)
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
    resetGame()
    
}

