abs = math.abs
sort = table.sort

getDistance = (p1, p2) ->
    x1, y1 = unpack p1
    x2, y2 = unpack p2
    (abs x1 - x2) + (abs y1 - y2)

getPointExtremes = (sensors) ->
    buffSens = {k, v for k, v in pairs sensors} 
    leftmostSensor = do
        sort buffSens, (a,b) -> (a.pos[1] - a.emptyRad) < (b.pos[1] - b.emptyRad) 
        buffSens[1]
    rightmostSensor = do
        sort buffSens, (a,b) -> (a.pos[1] + a.emptyRad) > (b.pos[1] + b.emptyRad) 
        buffSens[1]

    (leftmostSensor.pos[1] - leftmostSensor.emptyRad), (rightmostSensor.pos[1] + rightmostSensor.emptyRad)

class Sensor
    new: (pos, closest) =>
        @pos, @closest, @emptyRad = pos, closest, getDistance(pos, closest)

readLine = (line) ->
    x1, x2 = unpack [tonumber x\sub(3, #x) for x in line\gmatch "x=%-?[0-9]+"]
    y1, y2 = unpack [tonumber y\sub(3, #y) for y in line\gmatch "y=%-?[0-9]+"]
    {x1, y1}, {x2, y2}

data = [line for line in io.lines "15.data"]
allSensors = [Sensor readLine line for line in *data]
leftmostPoint, rightmostPoint = getPointExtremes allSensors
n = -1
for i=leftmostPoint, rightmostPoint
    for sensor in *allSensors
        if (getDistance sensor.pos, {i, 2000000}) <= sensor.emptyRad
            n += 1
            break

print n