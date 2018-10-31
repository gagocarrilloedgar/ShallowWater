function rp = r_Positive(Xprev, Xcurr, Xpost)

% Set case when the denominator is 0 and when it is not
    if ( Xpost - Xcurr ) == 0
        rp = 0;
    else
        rp = ( Xcurr - Xprev ) / ( Xpost - Xcurr );
    end

end