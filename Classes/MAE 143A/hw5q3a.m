function draw_zoh_plot()
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

        tzoh = repelem(yk, round(1/h));
        tk_adjusted = linspace(tk(1), tk(end), length(tzoh));

        plot(tk, yk, 'x', 'MarkerSize', 5, 'LineWidth', 2);
        stairs(tk_adjusted, tzoh, 'LineWidth', 1);
    end
    title('Zero-Order-Hold (ZOH) DAC Representation');
    xlabel('Time (s)');
    ylabel('Amplitude');
    legend('Continuous Sine Wave', 'Samples (h=0.1)', 'ZOH (h=0.1)', ...
           'Samples (h=0.2)', 'ZOH (h=0.2)', 'Samples (h=0.4)', 'ZOH (h=0.4)');
    grid on;
    hold off;
end
