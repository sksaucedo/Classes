function draw_soh_plot()
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

        t_soh = linspace(tk(1), tk(end), length(t_continuous));
        y_soh = zeros(size(t_continuous));

        for j = 3:length(tk)
            t_range = t_continuous >= tk(j - 2) & t_continuous <= tk(j);
            y_soh(t_range) = interpolate_soh(t_continuous(t_range), tk(j - 2), tk(j - 1), tk(j), yk(j - 2), yk(j - 1), yk(j), h);
        end

        plot(tk, yk, 'x', 'MarkerSize', 10, 'LineWidth', 2);
        plot(t_continuous, y_soh, 'LineWidth', 2);
    end

    title('Second-Order-Hold (SOH) DAC Representation');
    xlabel('Time (s)');
    ylabel('Amplitude');
    legend('Continuous Sine Wave', 'Samples (h=0.1)', 'SOH (h=0.1)', ...
           'Samples (h=0.2)', 'SOH (h=0.2)', 'Samples (h=0.4)', 'SOH (h=0.4)');
    grid on;
    hold off;
end

function y = interpolate_soh(t, tk_minus_2, tk_minus_1, tk, yk_minus_2, yk_minus_1, yk, h)
    a0 = yk_minus_2;
    a1 = (yk_minus_1 - yk_minus_2) / h;
    a2 = ((yk - yk_minus_1) / h - a1) / h;

    y = a0 + a1 * (t - tk_minus_2) + a2 * (t - tk_minus_2).^2;
end
