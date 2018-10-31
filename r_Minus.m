function rm = r_Minus( Xcurr,Xpost,Xnext)

if ( Xpost - Xcurr ) == 0
        rm = 0;
    else
        rm = ( Xnext - Xpost ) / ( Xpost - Xcurr );
    end


end