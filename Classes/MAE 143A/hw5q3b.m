function draw_foh_plot()
    omega = pi;
    t_continuous = 0:0.001:5;
    y_continuous = sin(omega * t_continuous);
    h_values = [0.1, 0.2, 0.4];
    figure;
    plot(t_continuous, y_continuous, 'LineWidth', 2);
    hold on;
    for i = 1:length(h_values)
        h = h_values(i);
        tk = 0:h:5;
        yk = sin(omega * tk);

        t_foh = linspace(tk(1), tk(end), length(t_continuous));
        y_foh = zeros(size(t_continuous));
        
        for j = 1:length(tk) - 1
            t_range = t_continuous >= tk(j) & t_continuous <= tk(j + 1);
            y_foh(t_range) = yk(j) + (t_continuous(t_range) - tk(j)) .* (yk(j + 1) - yk(j)) / h;
        end

        plot(tk, yk, 'x', 'MarkerSize', 10, 'LineWidth', 2);
        plot(t_continuous, y_foh, 'LineWidth', 2);
    end
    title('First-Order-Hold (FOH) DAC Representation');
    xlabel('Time (s)');
    ylabel('Amplitude');
    legend('Continuous Sine Wave', 'Samples (h=0.1)', 'FOH (h=0.1)', ...
           'Samples (h=0.2)', 'FOH (h=0.2)', 'Samples (h=0.4)', 'FOH (h=0.4)');
    grid on;
    hold off;
end
