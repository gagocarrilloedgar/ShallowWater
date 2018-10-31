function Gamma = GammaDelim(r)

Gamma = max([ 0, min([2 * r; 1]), min([r; 2]) ]);

end