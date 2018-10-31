function UM = U_Minus(U1,U2,rM,CM)
 UM = U2 - GammaDelim(rM) * 0.5 * ( 1 + CM ) * ( U2 - U1 );
 end