function [us,vs] = SymbolicVelocities(x,y,L,t)

us = sin(2 * pi * x) * cos(2 * pi * y) * t;
vs = cos(2 * pi * x) * sin(2 * pi * y) * t;

end