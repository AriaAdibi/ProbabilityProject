%i <--> S_i
function myDefaultFigureProperties( fig, i )
    fig.Color = [231/256, 252/256, 254/256];
    fig.ToolBar = 'none';
    ax= fig.CurrentAxes;
    ax.FontSize = 10;
    xlabel( sprintf('S_{%d}', i ), 'FontWeight', 'bold' );
    ylabel( {'Probability'; 'Mass'; 'Function'}, 'FontWeight', 'bold' );
    ylim( [0, 1] );
end