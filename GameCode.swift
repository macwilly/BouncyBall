import Foundation
let ball = OvalShape(width: 40, height: 40)

var barriers: [Shape] = []
var targets: [Shape] = []

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

func setupBall() {
    
    
    scene.add(ball)
    ball.position = Point(x: 250, y: 400)
    ball.hasPhysics = true
    ball.fillColor = .blue
    ball.isDraggable = false
    ball.bounciness = 0.6
    ball.onCollision = ballCollided(with:)
    ball.onExitedScene = ballExitedScene
    ball.onTapped = resetGame
    scene.trackShape(ball)
    //This will add the object to the screen
    
}

func addBarrier(at position: Point, width: Double, height: Double, angle: Double) {
    let barrierPoints = [
        Point(x: 0, y: 0),
        Point(x: 0, y: height),
        Point(x: width, y: height),
        Point(x: width, y: 0)
    ]
    
    let barrier = PolygonShape(points: barrierPoints)
    
    barriers.append(barrier)
    
    barrier.isDraggable = true
    barrier.position = position
    barrier.hasPhysics = true
    barrier.isImmobile = true
    barrier.fillColor = .black
    barrier.angle = angle
    scene.add(barrier)
}

func setupFunnel() {
    //can do a calculation as a variable for Point
    funnel.position = Point(x: 200, y: scene.height - 25)
    //started as black but I wanted to actually set the color
    funnel.fillColor = .black
    funnel.isDraggable = false
    scene.add(funnel)
    //page 229 on how you are able to call the dropBall function without the ()
    funnel.onTapped = dropBall
}

func addTarget(at position: Point) {
    let targetPoints = [
        Point(x:10, y:0),
        Point(x:0, y:10),
        Point(x:10, y:20),
        Point(x:20, y:10)
    ]
    
    var target = PolygonShape(points: targetPoints)
    
    targets.append(target)
    
    target.position = position
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
    
    for barrier in barriers {
        barrier.isDraggable = false
    }
    
}


func ballExitedScene() {
    for barrier in barriers {
        barrier.isDraggable = true
    }
    
}

func resetGame() {
    for barrier in barriers {
        barrier.isDraggable = true
    }
    
    for target in targets{
        target.fillColor = .red
    }
    
    ball.position = Point(x: 0, y: -80)
}

func printPosition(of shape: Shape) {
    print(shape.position)
}

func setup() {
    // Add circle to scene
    setupBall()
    // Add barrier to scene
    addBarrier(at: Point(x: 200, y: 150), width: 80, height: 25, angle: 0.1)
    addBarrier(at: Point(x: 200, y: 50), width: 50, height: 25, angle: -0.2)
    addBarrier(at: Point(x: 100, y: 50), width: 50, height: 25, angle: 0.5)
    //Add funnel to scene
    setupFunnel()
    
    //adding a target
    addTarget(at: Point(x: 100.49991607666016, y: 478.49969482421875))
    addTarget(at: Point(x: 155.999, y: 261.993))
    addTarget(at: Point(x: 35.999, y: 85.499))

    scene.onShapeMoved = printPosition(of:)
    resetGame()
    
}

