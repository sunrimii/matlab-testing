classdef Monster
    properties
        theta
        pos_of_body
        body;
        pos_of_knee;
        r_of_knee;
        len_of_leg;
    end
    
    methods
        function monster = Monster()
            monster.theta = linspace(0, 2*pi, 45);
            
            monster.pos_of_body = [0; 0];
            r_of_body = 2;  
            monster.body = [cos(monster.theta); sin(monster.theta);] * r_of_body + monster.pos_of_body;

            monster.pos_of_knee = [[8; 0] [-8; 0]];
            monster.r_of_knee = 6;

            monster.len_of_leg = 8;
        end
        
        function update(monster, A)
            C2G = monster.len_of_leg;
            BC1 = monster.r_of_knee;
            
            for B = monster.pos_of_knee
                AB = norm(A - B);
                AC = norm(monster.pos_of_body - B) * 1.3; % ���
                ABC1 = acos((BC1^2 + AB^2 - AC^2) / (2 * BC1 * AB)); % �l���w�z
                ABC1_offest = asin((A(2) - B(2)) / AB); % ���i��acos((A(1) - B(1)) / AB)
                if B(1) < monster.pos_of_body % �Y���\�b���骺����
                    C1 = [cos(ABC1 + ABC1_offest); sin(ABC1 + ABC1_offest)] * BC1 + B;
                    C2 = [cos(-ABC1 + ABC1_offest); sin(-ABC1 + ABC1_offest)] * BC1 + B;
                    D = [0 -1; 1 0] * (C1 - B) + B;
                else % �Y���\�b���骺�k��
                    C1 = [cos(pi - (ABC1 + ABC1_offest)); sin(pi - (ABC1 + ABC1_offest))] * BC1 + B;
                    C2 = [cos(pi - (-ABC1 + ABC1_offest)); sin(pi - (-ABC1 + ABC1_offest))] * BC1 + B;
                    D = [0 1; -1 0] * (C1 - B) + B; % �����^���A����A����
                end
                
                E = (D + C2) / 2;
                F = (E - B) * 2 + B; % ��² F = ((E - B) - (B - B)) * 2 + B;
                if B(1) < monster.pos_of_body % �Y���\�b���骺����
                    G = ([0 -1; 1 0] * (F - C2)) / norm(F - C2) * C2G  + C2; % ��² G = [0 -1; 1 0] * ((F - B) - (C2 - B)) / norm(F - C2) * C2G + C2;
                else % �Y���\�b���骺�k��
                    G = ([0 1; -1 0] * (F - C2)) / norm(F - C2) * C2G  + C2; % ��² G = [0 -1; 1 0] * ((F - B) - (C2 - B)) / norm(F - C2) * C2G + C2;
                end
                
                knee = [cos(monster.theta); sin(monster.theta)] * BC1 + B;
                plot(knee(1,:), knee(2,:));hold on;
                plot(monster.body(1,:), monster.body(2,:));hold on;

%                 points = [A B C1 C2 D E F G]';
%                 points_names = {'A', 'B', 'C1', 'C2' 'D', 'E', 'F', 'G'};
%                 for ii = 1: length(points)
%                 % �e�I
%                     plot(points(ii, 1), points(ii, 2), 'o');hold on;
%                 % ��ܤ�r
%                     text(points(ii, 1), points(ii, 2), points_names(i));
%                 end

                lines = [A' C1'; A' C2'; B' C1'; B' C2'; B' D'; B' C2'; F' D'; F' C2'; G' F'; G' C2'];
                for iii = 1: size(lines, 1)
                   % �e�u
                   plot([lines(iii, 1) lines(iii, 3)], [lines(iii, 2) lines(iii, 4)]);hold on;
                end
                
%                 disp(AC)
            end
            
            hold off;
            axis([-15 15 -15 15]);
        end
    end 
end

