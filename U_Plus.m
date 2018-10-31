function UP = U_Plus(U1,U2,rP,CP)
UP = U1 + GammaDelim(rP) * 0.5 * ( 1 - CP ) * ( U2 - U1 );
end