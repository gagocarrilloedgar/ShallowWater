% FILE plotSavedMAPS.m
% ====================
%
% DESCRIPTION
% -----------
% Returns an animated plot of the variables specified in MAPS, i.e. MAPS = {u_save eta_save} with the colormap specified in COLORMAPS, i.e. COLORMAPS = {blues reds}. The legend is specified in TAGS, i.e. TAGS  = {'key 1', 'key 2'} while the filename is specified in filename
%
% INPUTS
% ------
% - MAPS: the cell array containing the snapshots of the variable at a given timestep
% - COLORMAPS: the cell array containing the matrices with the colors for each z level (see surf2colormap.m)
% - TAGS: the cell array containing the strings of the legend
% - filename: the name of the file to be produced
%

function plotSavedMAPS(MAPS, COLORMAPS, TAGS, filename, plot_period)

    % Import colormaps
    custom_colormaps;
    
    % Import variables that are often used
    InitsMap;

    % Determine the number of MAPs to be plotted and passed through MAPS
    num_MAPS = length(MAPS);

    figure;
    for t = 1:plot_period:T

        for m = 1:num_MAPS

            % Get one the elements of the cell arrays
            MAP = MAPS{m};
            COLORMAP = COLORMAPS{m};

            % Get matrix size
            [M, N, T] = size(MAP);

            % Asssign colormap
            RGB_COLORMAP = surf2colormap(MAP, COLORMAP, T);

            % Ensure notation consistency between files
            M = M - 4;
            N = N - 4;

            % Compute maximum and minimum of the MAP
            lower_limit = min(min(min(MAP)));
            upper_limit = max(max(max(MAP)));

            % Set limits if ther is an error
            if lower_limit == upper_limit
                upper_limit = 2;
                lower_limit = 0;
            end

            % Print limits
            % fprintf('lower_limit = %d\nupper_limit = %d\n', [lower_limit upper_limit]);

            % permute(RGB_COLORMAP(:, :, t, :), [2 1 4 3]) returns the COLORMAP aligned with transpose(MAP(:,:,t))
            surf(transpose(MAP(:,:,t)), permute(RGB_COLORMAP(:, :, t, :), [2 1 4 3]));

            shading interp

            % Set viewpoint
            view(-37.5, 70);

            % Set axis limits
            xlim([1, M+4]);
            ylim([1, N+4]);
            zlim([lower_limit upper_limit]);
            

            % Set title
            title(filename);

            hold on
        end

        % Add legend
        legend(TAGS);

        hold off

        % Plot at every iteration
        drawnow;

        % Store the plot
        frame = getframe(1);
        curr_frame = 1;
        im{curr_frame} = frame2im(frame);

        % Print status
        fprintf('Frame #%d plotted\n', t);

        % Write GIF file

        [A, map] = rgb2ind(im{curr_frame}, 256);
        if t == 1
            imwrite(A, map, filename, 'gif', 'LoopCount', Inf, 'DelayTime', 0);
        else
            imwrite(A, map, filename, 'gif', 'WriteMode', 'append', 'DelayTime', 0);
        end

        curr_frame = curr_frame + 1;

        % Print status
        fprintf('Frame #%d saved\n', t);

    end
    hold off

%     Create GIF
%     [a, b]  = findIntegerFactorsCloseToSquareRoot(t);
%     
%     figure;
%     for t = 1:T
%     
%     %    subplot(b, a, t);
%     %    imshow(im{t});
%         [A, map] = rgb2ind(im{t}, 256);
%     
%         if t == 1
%             imwrite(A, map, filename, 'gif', 'LoopCount', Inf, 'DelayTime', 0);
%         else
%             imwrite(A, map, filename, 'gif', 'WriteMode', 'append', 'DelayTime', 0);
%         end
%     
%         fprintf('Frame #%d saved\n', t);
%     end
end
