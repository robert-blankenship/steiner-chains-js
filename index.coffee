console.log 'hello world'

canvas = document.getElementById 'canvas'
canvas.width = 400
canvas.height = 400
context = canvas.getContext '2d'

rotateAroundPoint = (x1, y1, radians) ->
    context.translate x1, y1
    context.rotate radians
    context.translate -x1, -y1

drawFractal = (parentCircleRadius, context, fractalArray) ->
    numberOfCircles = fractalArray[0]

    r = (parentCircleRadius) *
            Math.sin(Math.PI / numberOfCircles) / (1 + Math.sin(Math.PI / numberOfCircles))
    
    angleStart = 0
    angleEnd = 2 * Math.PI

    for circle in [1..numberOfCircles]
        rotateAroundPoint parentCircleRadius, context.canvas.height / 2, (2 * Math.PI / numberOfCircles)
        context.beginPath()
        context.arc r, context.canvas.height / 2, r, angleStart, angleEnd
        context.stroke()

        if fractalArray.length > 1
            drawFractal(r, context, fractalArray[1..])
    

angular.module 'Application', ['ngMaterial']

    .controller 'FractalController', ($scope) ->

        $scope.fractalOptions = {}
        $scope.fractalOptions.levels = [3, 3]
        $scope.fractalOptions.levelsCount = 2

        $scope.setLevels = (levelsCount) ->
            while $scope.fractalOptions.levels.length > levelsCount
                $scope.fractalOptions.levels.pop()
            while $scope.fractalOptions.levels.length < levelsCount
                $scope.fractalOptions.levels.push(3)

        $scope.drawImage = ->
            console.log $scope.fractalOptions.levels
            context.clearRect(0, 0, canvas.width, canvas.height);
            drawFractal(canvas.width / 2, context, $scope.fractalOptions.levels)

        $scope.drawImage()


