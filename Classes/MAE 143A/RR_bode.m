function RR_bode(L,g)
        % function RR_bode(L,g)
        % Plots the continuous-time Bode plot of L(s) if L.h is not defined, with s=(i omega),
        % or    the discrete-time   Bode plot of L(z) if L.h is defined,     with z=e^(i omega h).
        % The (optional) derived type g is used to pass in various (optional) plotting parameters:
        %   {g.log_omega_min,g.log_omega_max,G.omega_N} define the set of frequencies used (logarithmically spaced)
        %   g.ls is the linestyle used
        %   g.lines is a logical flag turning on/off horizontal_lines at gain=1 and phase=-180 deg
        %   g.phase_shift is the integer multiple of 360 deg added to the phase in the phase plot.
        %   g.Hz is a logical that, if true, handles all frequencies (inputs and plotted) in Hz
        % Convenient defaults are defined for each of these fields of g if not provided.
        % TEST: omegac=1; F=RR_tf([omegac^2],[1 2*0.707*omegac omegac^2]); close all, RR_bode(F)
        % Renaissance Robotics codebase, Chapter 9, https://github.com/tbewley/RR
        % Copyright 2024 by Thomas Bewley, distributed under BSD 3-Clause License. 
            if nargin==1, g=[]; end,     % Convenient defaults for the plotting parameters
            c=1; if ~isfield(g,'Hz'  ),  g.Hz=false;                       
                 elseif g.Hz==true,      c=2*pi;      end
            p=[abs([L.z L.p])]/c;  if sum(p)==0, p=1; end
            if     ~isfield(g,'log_omega_min'), g.log_omega_min=floor(log10(min(p(p>0))/5)); end
            % (In DT, always plot the Bode plot up to the Nyquist frequency, to see what's going on!)
            if     ~isempty(L.h              ), Nyquist=pi/L.h/c; g.log_omega_max=log10(0.999*Nyquist);
            elseif ~isfield(g,'log_omega_max'), g.log_omega_max= ceil(log10(max(p(p>0))*5)); end
            if     ~isfield(g,'omega_N'      ), g.omega_N      =500;                         end
            if     ~isfield(g,'ls'    ), if isempty(L.h), g.ls ='b-';
                                         else             g.ls ='r-';  end,    end
            if     ~isfield(g,'lines'        ), g.lines        =false;                       end
            if     ~isfield(g,'phase_shift'  ), g.phase_shift  =0;                           end
            omega=logspace(g.log_omega_min,g.log_omega_max,g.omega_N);
            if     ~isempty(L.h), arg=exp(i*omega*c*L.h); else, arg=i*omega*c; end

            mag=abs(RR_evaluate(L,arg)); phase=RR_phase(RR_evaluate(L,arg))*180/pi+g.phase_shift*360;

            if g.lines
            for k=1:g.omega_N-1; if (mag(k)  -1  )*(mag(k+1)  -1  )<=0;
                omega_c=(omega(k)+omega(k+1))/2, phase_margin=180+(phase(k)+phase(k+1))/2
            break, end, end
            for k=1:g.omega_N-1; if (phase(k)+180)*(phase(k+1)+180)<=0;
                omega_g=(omega(k)+omega(k+1))/2, gain_margin=1/(mag(k)+mag(k+1))/2
            break, end, end
            end

            subplot(2,1,1),          loglog(omega,mag,g.ls), hold on, a=axis; grid on
            if g.lines,              plot([a(1) a(2)],[1 1],'k:')
                if exist('omega_c'), plot([omega_c omega_c],[a(3) a(4)],'k:'), end
                if exist('omega_g'), plot([omega_g omega_g],[a(3) a(4)],'k:'), end, end
            if ~isempty(L.h),        plot([Nyquist Nyquist],[a(3) a(4)],'k-'), end, axis(a)
            if isfield(g,'axis1'),   axis(g.axis1), end

            subplot(2,1,2),          semilogx(omega,phase,g.ls), hold on, a=axis; grid on
            if g.lines,              plot([a(1) a(2)],[-180 -180],'k:')
                if exist('omega_c'), plot([omega_c omega_c],[a(3) a(4)],'k:'), end
                if exist('omega_g'), plot([omega_g omega_g],[a(3) a(4)],'k:'), end, end
            if ~isempty(L.h),        plot([Nyquist Nyquist],[a(3) a(4)],'k:'), end, axis(a) 
            if isfield(g,'axis2'),   axis(g.axis2), end
        end % function RR_bode