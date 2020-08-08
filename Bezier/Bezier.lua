local BezModule = {}

local function CalculateLinearBezierPoint(t, p0, p1)
	return p0 + t * (p1 - p0)
end

local function CalculateQuadraticBezierPoint(t, p0, p2, p1)
	return CalculateLinearBezierPoint(t, CalculateLinearBezierPoint(t, p0, p1), CalculateLinearBezierPoint(t, p1, p2))
end

function BezModule:LineRender(Positions)
	local Debris = game:GetService("Debris")
	
	for i = 1, #Positions do
		local Part = Instance.new("Part")
		Part.Size = Vector3.new(1, 1, 1)
		Part.Anchored = true
		Part.CanCollide = false
		Part.Position = Positions[i]
		Part.Parent = workspace
		Debris:AddItem(Part, 5)
	end
end

function BezModule:SolveForEndpoint(t, p0, P)
	return (P - (1 - t) * p0) / t
end

function BezModule:SolveForControlPoint(t, p0, p1)
	return ((1 - t) * p0) + (t * p1)
end

function BezModule:NewLinearCurve(NumOfPoints, p0, p1)
	local Positions = {}
	
	for i = 1, NumOfPoints do
		local t = i / NumOfPoints
		Positions[i] = CalculateLinearBezierPoint(t, p0, p1)
	end
	
	return Positions
end

function BezModule:NewQuadraticCurve(NumOfPoints, p0, p1, p2)
	local Positions = {}

	for i = 1, NumOfPoints do
		local t = i / NumOfPoints
		Positions[i] = CalculateQuadraticBezierPoint(t, p0, p1, p2)
	end
	
	return Positions
end

return BezModule
