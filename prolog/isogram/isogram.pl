% An isogram (also known as a "non-pattern word") is a word or phrase
% without a repeating letter, however spaces and hyphens are allowed 
% to appear multiple times.

remove_spaces_and_dashes(Input, Result) :-
    atom_codes(Input, InputCodes), % convert input string to char code list
    filter_spaces_and_dashes(InputCodes, FilteredCodes), % remove spaces and dashes
    atom_codes(Result, FilteredCodes). % convert back to a string

% base case
filter_spaces_and_dashes([], []). 

% Remove spaces (32)
filter_spaces_and_dashes([32|Rest], FilteredRest) :-
    filter_spaces_and_dashes(Rest, FilteredRest).

% Remove dashes (45)
filter_spaces_and_dashes([45|Rest], FilteredRest) :-
    filter_spaces_and_dashes(Rest, FilteredRest).

% Keep other characters unchanged
filter_spaces_and_dashes([X|Rest], [X|FilteredRest]) :-
    filter_spaces_and_dashes(Rest, FilteredRest).

process_string(Input, Result) :-
    string_lower(Input, LowerCaseInput),
    remove_spaces_and_dashes(LowerCaseInput, Result).

isogram("").

% Predicate to check if a string is an isogram
isogram(Phrase) :-
    process_string(Phrase, ProcessedPhrase),
    atom_chars(ProcessedPhrase, CharList),
    isogram_list(CharList).

% Base case: an empty string is an isogram
isogram_list([]).

% Check if a character is not a member of the rest of the characters
isogram_list([H | T]) :-
    \+ member(H, T), % Char is not a member of Seen
    isogram_list(T).