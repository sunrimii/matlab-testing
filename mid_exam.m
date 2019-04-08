theta = linspace(0, 2*pi, 50);

% �j��
big_circle_x0y0 = [-5; 0];
big_circle_r = 6;
big_circle = [cos(theta); sin(theta)] * big_circle_r + big_circle_x0y0;

% �p��
small_circle_x0y0 = [10; 0];
small_circle_r = 2;
small_circle = [cos(theta); sin(theta);] * small_circle_r + small_circle_x0y0;

B = big_circle_x0y0;
AC = 17; % ���
C2G = 8; % �L��
BC1 = big_circle_r;

% while 1 
    for A = small_circle
       AB = norm(A - B);
       ABC1 = acos((BC1^2 + AB^2 - AC^2) / (2 * BC1 * AB)); % �l���w�z
       ABC1_offest = asin((A(2) - B(2)) / AB); % ���i��acos((A(1)-B(1))/AB)
       C1 = [cos(ABC1 + ABC1_offest); sin(ABC1 + ABC1_offest)] * BC1 + big_circle_x0y0;
       C2 = [cos(-ABC1 + ABC1_offest); sin(-ABC1 + ABC1_offest)] * BC1 + big_circle_x0y0;
       D = [0 -1; 1 0] * (C1 - big_circle_x0y0) + big_circle_x0y0; % �����^���A����A����
       E = (D + C2) / 2;
       F = (E - B) * 2 + big_circle_x0y0; % ��² F = ((E - big_circle_x0y0) - (B - big_circle_x0y0)) * 2 + big_circle_x0y0;
       G = ([0 -1; 1 0] * (F - C2)) / norm(F - C2) * C2G  + C2; % ��² G = [0 -1; 1 0] * ((F - big_circle_x0y0) - (C2 - big_circle_x0y0)) / norm(F - C2) * C2G + C2;
       
       % �e�j��p��
       plot(big_circle(1,:), big_circle(2,:));hold on;
       plot(small_circle(1,:), small_circle(2,:));hold on;
       
       points = [A B C1 C2 D E F G]';
       points_names = {'A', 'B', 'C1', 'C2' 'D', 'E', 'F', 'G'};
       for i = 1: length(points)
           % �e�I
            plot(points(i, 1), points(i, 2), 'o');hold on;
           % ��ܤ�r
           text(points(i, 1), points(i, 2), points_names(i));
       end
       
       lines = [A' C1'; A' C2'; B' C1'; B' C2'; B' D'; B' C2'; F' D'; F' C2'; G' F'; G' C2'];
       for i = 1: size(lines, 1)
           % �e�u
           plot([lines(i, 1) lines(i, 3)], [lines(i, 2) lines(i, 4)]);hold on;
       end
       
       hold off;
       axis([-15 15 -15 15]);
       
       pause(0.001)
    end
% end