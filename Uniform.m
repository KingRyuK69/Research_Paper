% Prompt the user to input the number of rows and columns for t_dh
n_dh = input('Enter the number of rows for t_dh: ');
m_dh = input('Enter the number columns for t_dh: ');

% Prompt the user to input the number of rows and columns for t_h
n_h = input('Enter the number of rows and columns for t_h: ');
m_h = n_h;

% Generate random values for t_dh and t_h
t_dh = rand(n_dh, m_dh);

disp(t_dh)

t_h = rand(n_h, m_h);

disp(t_h)

% Normalize the matrices so that the rows of t_dh and the columns of t_h all sum to 1
t_dh = t_dh ./ sum(t_dh, 2);
t_h = t_h ./ sum(t_h, 1);

% Set the diagonal elements of t_h to 0
t_h(1:n_h+1:end) = 0;

% Initialize tol
tol = 0.01;

% Set the number of runs for the loop
num_runs = 5;

% Open a new file to store the output
file = fopen('output.txt', 'w');

% Loop over the range of inputs for h and d
for i = 1:num_runs

    % Generate random values for h and d within the range of 0.1 to 0.9
    h = 0.8 * rand(1, n_h) + 0.1;
    d = 0.8 * rand(1, n_dh) + 0.1;

    % Calculate the matrix S using the formula S = h + d * t_dh
    S = h + d * t_dh;

    % Display the resulting matrix S
    disp(S)

    % Set a while loop with a condition 
    while true

        % Calculate the matrix S1 using the formula S1 = S * t_h
        S1 = S * t_h;

        % Write the values of S1 to the file
        fprintf(file, '%f ', S1);
        fprintf(file, '\n');

        % Calculate the difference C between S1 and S
        C = S1 - S;  

        % Print the current value of norm(C)
        fprintf('Current value : %f\n', norm(C));

        % If the norm of C is less than tol, break out of the loop
        if norm(C) < tol
            break;
        end

        % Update S to be equal to S1
        S = S1;

    end  

    % Display the final value of norm(C)
    fprintf('Final value : %f\n', norm(C));
end

% Close the file
fclose(file);
