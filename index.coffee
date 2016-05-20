console.log 'hello world'

drawFractal = (s, depth)  ->
    canvas = document.getElementById 'canvas'
    canvas.width = s
    canvas.height = s
    context = canvas.getContext '2d'
    
    rotateAroundPoint = (x1, y1, radians) ->
        context.translate x1, y1
        context.rotate radians
        context.translate -x1, -y1
    
    drawCircles = (parentCircleRadius, context, numberOfCircles) ->
        r = (parentCircleRadius) *
                Math.sin(Math.PI / numberOfCircles) / (1 + Math.sin(Math.PI / numberOfCircles))
        
        angleStart = 0
        angleEnd = 2 * Math.PI

        for circle in [1..numberOfCircles]
            rotateAroundPoint s / 2, parentCircleRadius, (2 * Math.PI / numberOfCircles)
            context.beginPath()
            context.arc r, parentCircleRadius, r, angleStart, angleEnd
            context.stroke()

    drawSameFractal = (parentCircleRadius, context, depth, maxDepth, numberOfCircles) ->
        r = (parentCircleRadius) *
                Math.sin(Math.PI / numberOfCircles) / (1 + Math.sin(Math.PI / numberOfCircles))
        
        angleStart = 0
        angleEnd = 2 * Math.PI

        for circle in [1..numberOfCircles]
            rotateAroundPoint parentCircleRadius, s / 2, (2 * Math.PI / numberOfCircles)
            context.beginPath()
            context.arc r, s/2, r, angleStart, angleEnd
            context.stroke()
            
            if depth < maxDepth
                drawSameFractal(r, context, depth + 1, maxDepth, numberOfCircles)
    
    drawFractal = (parentCircleRadius, context, fractalArray) ->
        numberOfCircles = fractalArray[0]

        r = (parentCircleRadius) *
                Math.sin(Math.PI / numberOfCircles) / (1 + Math.sin(Math.PI / numberOfCircles))
        
        angleStart = 0
        angleEnd = 2 * Math.PI

        for circle in [1..numberOfCircles]
            rotateAroundPoint parentCircleRadius, s / 2, (2 * Math.PI / numberOfCircles)
            context.beginPath()
            context.arc r, s/2, r, angleStart, angleEnd
            context.stroke()

            if fractalArray.length > 1
                drawFractal(r, context, fractalArray[1..])
        
    drawFractal(s/2, context, [11,4,5])
    #context.stroke()

drawFractal 400, 2

