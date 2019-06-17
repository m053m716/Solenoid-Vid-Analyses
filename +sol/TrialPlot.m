%%Plot curve after each trial 
xdcurrent = darray([(end-10)+1:end],1);
        xscurrent = sarray([(end-10)+1:end],1);
        x = xscurrent - xdcurrent;
        ydcurrent = darray([(end-10)+1:end],2);
        yscurrent = sarray([(end-10)+1:end],2);
        y = yscurrent - ydcurrent;
        xt = sarray([(end-10)+1:end],3);
        d = (x.^2 + y.^2).^(1/2)
        pos2 = [0,0,1,1];
        FigUI2 = figure('Name','Plot','Units', 'normalized', 'Position',pos2,'Color','red');
        ax2=axes(FigUI2);
        ax2.XLim = [1,v.Width];
        ax2.YLim = [1,v.Height];
        im=imagesc(ax2,[1,v.Width],[1,v.Height],randn(v.Height,v.Width));
        Iplot = (plot(xt,d));
        plotarray = [plotarray;[xt,d]]
        dataarray = [dataarray; [xt,xdcurrent, xscurrent, x, ydcurrent, yscurrent, y, d]];