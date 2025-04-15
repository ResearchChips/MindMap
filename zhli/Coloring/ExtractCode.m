function ExtractCode
% slandarer
[filename, pathname] = uigetfile({'*.jpg;*.tif;*.png','All Image Files';'*.*','All Files' });
oriPath=[pathname,filename];
input2RGB(oriPath)

set(gcf,'KeyPressFcn',@key)
    function key(~,event)
        switch event.Key%将按键动作转换
            case 's'

                tData=get(gcf,'UserData');
                close(findobj('Name','img fig'))
                pause(.01)
                createRGBPic(tData)
        end
    end
    function createRGBPic(CCList)
        drawPalette(CCList)
        pause(.01)
        close(findobj('Name','color fig'))

        imgCP=imread('temp.png');
        imgOR=imread(oriPath);
        % imshow(imgCP)
        % figure()
        % imshow(imgOR)
        [~,C1,~]=size(imgCP);
        [R2,C2,~]=size(imgOR);
        imgOR2=imresize(imgOR,[round(R2/C2*C1),C1]);
        imgNEW=[];
        imgNEW(:,:,1)=[imgOR2(:,:,1);imgCP(:,:,1)];
        imgNEW(:,:,2)=[imgOR2(:,:,2);imgCP(:,:,2)];
        imgNEW(:,:,3)=[imgOR2(:,:,3);imgCP(:,:,3)];
        if ~exist([pathname,'\result\'],'dir')
            mkdir([pathname,'\result\'])
        end
        imwrite(uint8(imgNEW),[pathname,'\result\',filename])
        imshow(uint8(imgNEW))
    end

    function input2RGB(imgLink)
        if nargin<1
            imgLink='.\test.png';
        end
        img=imread(imgLink);
        imgFig=figure('Name','img fig','Position',[10,50,500,900]);
        [row,col,~]=size(img);
        imgFig.Position(3)=round(900*col/row);

        ax=gca;hold on;
        ax.Position=[0,0,1,1];
        ax.Toolbar.Visible='off';
        imshow(img)
        colormap(zeros(0,3))
        cbHdl=colorbar();
        cbHdl.YColor='none';
        axis tight

        CList=zeros(0,3);
        set(imgFig,'WindowButtonDownFcn',@getPoints)
        function getPoints(~,~)
            if strcmp(get(gcf,'SelectionType'),'normal')
                xy=get(ax,'CurrentPoint');
                xp=xy(1,2);yp=xy(1,1);
                xp(xp<1)=1;yp(yp<1)=1;
                xp(xp>row)=row;yp(yp>col)=col;
                tColor=img(round(xp),round(yp),:);
                tColor=tColor(:).';
                CList=[CList;tColor];
                imgFig.UserData=CList;
                colormap(flipud(CList))
            else
                if size(CList,1)>0
                    CList(end,:)=[];
                    imgFig.UserData=CList;
                    colormap(flipud(CList))
                end
            end
        end
    end

    function drawPalette(CList)
        colorFig=figure('Name','color fig','Position',[10,50,700,900]);
        ax=gca;hold on;ax.Toolbar.Visible='off';
        ax.Position=[0,0,1,1];
        N=size(CList,1);
        ax.YLim=[0,ceil(N/3)];
        ax.XLim=[0,3];
        ax.XTick=[];
        ax.YTick=[];
        ax.XColor=[1,1,1].*.99;
        ax.YColor=[1,1,1].*.99;
        ax.YDir='reverse';
        colorFig.Position(4)=100*ceil(N/3);
        colorFig.Position(2)=900-100*ceil(N/3);

        blockX=[(-1:.1:1).*.8   , cos(linspace(-pi/2,0,50))*.2+.8   ,  ones(1,21)     , cos(linspace(0,pi/2,50))*.2+.8,...
                (1:-.1:-1).*.8  , cos(linspace(pi/2,pi,50))*.2-.8   , -ones(1,21)     , cos(linspace(-pi,-pi/2,50))*.2-.8];
        blockY=[-ones(1,21)     , sin(linspace(-pi/2,0,50))*.2-.8   , (-1:.1:1).*.8   , sin(linspace(0,pi/2,50))*.2+.8,...
                 ones(1,21)     , sin(linspace(pi/2,pi,50))*.2+.8   , (1:-.1:-1).*.8  , sin(linspace(-pi,-pi/2,50))*.2-.8];

        for i=1:N
            row=ceil(i/3);
            col=i-(row-1)*3;
            fill(blockX.*.12+.2+(col-1),blockY.*.3+(row-1)+.5,double(CList(i,:))./255,'EdgeColor',[.2,.2,.2],'LineWidth',1.2)
            text(.15+.24+(col-1),(row-1)+.5+.12,['RGB:',CStr(CList(i,:))],'FontSize',12,...
                'FontName','Comic Sans MS')
            text(.15+.24+(col-1),(row-1)+.5-.12,['HEX: ',ten2sixteen(double(CList(i,:)))],'FontSize',12,...
                'FontName','Comic Sans MS')
        end

        function CS=CStr(C)
            CS='';
            for ii=1:3
                tC='   ';
                ttC=num2str(C(ii));
                tC(1+3-length(ttC):end)=ttC;
                CS=[CS,' ',tC];
            end
        end

        function string=ten2sixteen(num)
            %the num should be a 1x3 Integer mat limited in [0 255]
            exchange_list={'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'};
            string='#';
            for ii=1:3
                temp_num=num(ii);
                string(1+ii*2-1)=exchange_list{(temp_num-mod(temp_num,16))/16+1};
                string(1+ii*2)=exchange_list{mod(temp_num,16)+1};
            end
        end
        % -------------------------------------------------------------------------
        exportgraphics(gca,'temp.png')
    end
end