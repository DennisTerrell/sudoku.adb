--Dennis Terrell W00884251
--Feb, 1 2011
--Sudoku Solver

with Ada.Command_Line, Ada.Text_IO, Ada.directories, Ada.exceptions, ada.integer_text_io;
use Ada.Command_Line, Ada.Text_IO, Ada.directories, Ada.exceptions, ada.integer_text_io;

Procedure sudoku is

	

	subtype length is character range '1' .. '9';
	type game is array (1 .. 9 , 1 .. 9) of character; 
	grid : game := (others => (others => ' '));
	puzzle : file_type;
	Argument_error : exception;
	line : string (1 .. 9);
	--x : integer;
	--solved : boolean;


	
--read in from file
--function to solve
	--find possible values	
	--row, col, or box
	--return boolean
--solve grid	
	--find first empty box
	--call function "solve"
	----if true assign # to box and repeat (recursion)


------------------------------------------------------------------------------
function check (grid: in game; row, column : in integer; p: in character) return boolean is
	block_size : integer := 3;

begin
	--checking 3x3 box 	
	for new_row in ((row-1) / block_size + 1) .. ((((row-1) / block_size) * block_size + 1) * block_size - 1) loop
            for new_column in ((column-1) / block_size) * block_size + 1 .. ((((column-1) / block_size) * block_size + 1) * block_size - 1) loop
                if p = grid(new_row, new_column) then 
                    return false;
                end if;
            end loop;
        end loop;

	for new_row in 1 .. 9 loop --checking rows
		if p = grid(new_row, column) then
			return false;
		end if;
	end loop;
	
	for new_column in 1 .. 9 loop -- checking columns
		if p = grid(row, new_column) then
			return false;
		end if;
	end loop;

        return true;

end check;

-----------------------------------------------------------------------------
function solve (grid: in game) return boolean is
		y_column, x_row : integer;
		updated_grid : game := grid;
begin

	x_row := 0; --initializing numbers to zero every time through the loop
	y_column := 0;

	for row in 1 .. 9 loop
		for column in 1 .. 9 loop 
			if updated_grid(row, column) = ' ' then -- if the row or column is a space then assign value
				x_row := row;	
				y_column := column;

				exit; 
			end if;
		end loop;
		exit when x_row = row;
	end loop;

	if x_row = 0 and y_column = 0 then --if the grid is full the puzzle is solved
		return true;
	end if ;

	for p in length'range loop
		--call check function
			if check(updated_grid, x_row, y_column, p) then --THIS DOESNT WORK WTF!!!! this should check numbers but doesn't seem to
				updated_grid(x_row, y_column) := p;

				if solve(updated_grid) = true then --recursion WOOHOOO
					return;
				end if;
			end if;
	end loop;
	updated_grid(x_row, y_column) := ' ';
	return false;
			

				
end solve;
		
-----------------------------------------------------------------------



begin --sudoku

--read in from file and load grid

	if argument_count < 1 then 
		raise Argument_error;
	
	end if;
	open(puzzle, in_file, Argument(1));
	
	for g_row in 1 .. 9 loop
		for g_column in 1 .. 9 loop
			grid(g_row, g_column) := line(g_column);
		end loop;
	end loop;

	 if solve(grid) = true then 
		put("solved");
			for g_row in 1 .. 9 loop
				for g_column in 1 .. 9 loop
				put(grid(g_row,g_column));
					if g_column = 9 then
						new_line;
					end if; 
				end loop;
			end loop;
			else
			put("get a puzzle that can be solved!");
	end if;




exception
		
when argument_error =>
		Put_line("Please give the file name to load puzzle from.");
		





				 
end sudoku;
