import abs, max, min from math
import insert, sort from table
MAXD = 4000000

getDistance = (p1, p2) ->
    x1, y1 = unpack p1
    x2, y2 = unpack p2
    (abs x1 - x2) + (abs y1 - y2)

class Sensor
    new: (pos, closest) =>
        @pos, @closest, @emptyRad = pos, closest, getDistance(pos, closest)

readLine = (line) ->
    x1, x2 = unpack [tonumber x\sub(3, #x) for x in line\gmatch "x=%-?[0-9]+"]
    y1, y2 = unpack [tonumber y\sub(3, #y) for y in line\gmatch "y=%-?[0-9]+"]
    {x1, y1}, {x2, y2}

data = [line for line in io.lines "15.data"]
allSensors = [Sensor readLine line for line in *data]
isAvailable = (p, ss) ->
    return false for s in *ss when (getDistance s.pos, p) <= s.emptyRad
    return true

getPerimeter = (sensor) ->
    buff, rad = {}, sensor.emptyRad + 1
    x, y = unpack sensor.pos
    for i=(max 0, x-rad), (min MAXD, x+rad)
        yDist = abs(i-x) - rad
        if (y-yDist)>=0 and (y+yDist)<=MAXD
            insert buff, {i, y-yDist}
            insert buff, {i, y+yDist}
    buff

found = false
for sensor in *allSensors
    for point in *(getPerimeter sensor)
        x,y = unpack point
        continue unless x >= 0 and x <= MAXD
        continue unless y >= 0 and y <= MAXD
        if isAvailable point, allSensors
            p1, p2 = unpack point
            print p1 * MAXD + p2
            found = true
            break
    break if found