function mesh = CreateStaggeredMesh(M,N,L)

 % Compute the coordinates in the x direction
    for  i = 1:M + 4
        mesh.sx(i) = L / M * (i - 2);
        mesh.cx(i) = L / M * (i - 0.5 - 2);
    end

    % Compute the coordinates in the y direction
    for j = 1:N + 4
        mesh.sy(j) = L / N * (j - 2);
        mesh.cy(j) = L / N * (j - 0.5 - 2);
    end

end