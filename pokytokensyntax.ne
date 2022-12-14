# This is a WIP Poky Lexer Grammar - note it is susbantial a k9 tokenizer
# It likely makes sense to tokenize the Poky keywords as well rather than leave them in the grammar?
# Given Poky allows user functions to added as operators and NamedFunctions 
# These are likely best defined as tables

# Generate Charts - ./railroad ./dave/pokytokensyntax.ne -o ./dave/railroads/pokytokensyntax.html      

Grammar -> Token:*

Token  -> Comment 
        | Command
        | Name 
        | Character
        | String
        | Separator 
        | Unary
        | Binary
        | UnaryFcn
        | BinaryFcn
        | DateTime
        | Number
        | Datetime
        | Ident
        
Character -> "\"" ([^"] | "\\\"") "\"" # " any single character "

String -> "\"" ([^"] | "\\\""):* "\"" # " any character sequence "

Comment -> [/§] [^\n]:* "\n" # comment to end of line @Edgar  

Command -> "\\" [^\n]:+ "\n" # system command 

Separator -> ";" 
           | ","
           | "⋯" # used for continue to next line @Edgar changed to elipses charcater 
# Poky has ability to continue a statement over multiple lines 
# semi-coln only needed for multiple stmts on same line

Unary -> "↕" # Flip - addded user function  flip
        | "+" # ascii flip from k9 @Edgar
        | "=>" # Pop print also supported returns value of arg
        | "==>" # Pop pretty print also supported - should look at Pop print fuctions?
        | "⎙" # "print" Print  added to user functions
        | "🖶" # "pprint" added to user functions
        | "-" # Minus 
        | "↑" # First 
        | "↓" # Last @edgar maps to last in k9
        | "&" # Where  overloaded - varies depending of type of arg - prefer k4 use of ?
        | "↔" # Reverse not used that often also added it as user function rev
        | "<" # Asc 
        | ">" # Desc 
        | "=" # Group 
        | "~" # Not 
        | "!" # Enum - overloaded - varies based on type of arg 
        | "^" # Sort asl added as User Function sort
        | "," # Enlist - this can be confusing
        | "∘" # Enlist - proposed symbol for enlist @ Edgar
        | "#" # Count 
        | "_" # Floor ⌊ would be better; and ⌉ celing ??
        | "$" # String
        | "?" # Unique used to be used for where in k4 which I preferred 
        | "@" # Type not used that often or ?? so also added as user function type
        | "." # Value not used that often so also added as user function value
        | ":^" # proposed ascii for return @Edgar
        | "⇑" # synbol for return @Edgar
        | ":!" # proposed ascii for signal @Edgar
        | "↟" # symbol for signal @Edgar
        | "◻" [0-5] # Poky IO Read @Edgar

Binary -> "→" # Assign - note it is dyadic and returns it's value
        | "->" # Ascii pop assignment also supportted returns its value
        | "+" # Plus 
        | "-" # Minus
        | "×" # Times
        | "÷" # Divide
        | "%" # Ascii for divide
        | "&" # MinAnd or perhaps ∧
        | "|" # MaxOr or perhaps ∨
        | "<" # Less and ideally ≤ which k9 doesn't support directly
        | ">" # More and ≥ ...
        | "=" # Equals
        | "~" # Match
        | "!" # Key
        | "," # Cat 
        | "∘" # Cat proposed altertive symbol @Edgar
        | "^" # Cut - Can take function as arg
        | "↑" # Take - Can take function as arg
        | "↓" # Drop - Can take function as arg
        | "$" # Parse really not commonly used could add parser to user function?
        | "?" # FindRand overloaded would prefer rnd or rand ? - varies on type pf arg
        | "@" # At - Can take function as arg
        | "." # Dot - Can take function as arg
        | "◼"  [0-5] # Poky IO write @Edgar

UnaryFnc -> "count"|"first"|"last"|"min"|"max"|"sum"|"dot"|"avg"|"var"|"dev"|"med"|"mode"|"countd"
        |"log"|"exp"|"sin"|"cos"|"sqr"|"sqrt"|"prm"|"sums"|"deltas"|"rev"|"type"|"sort"|"flip"
        | "print"|"pprint"

BinaryFnc -> "deltas"|"has"|"bin"|"in"|"within"|"div"|"mod"|"bar"|"msum"|"mavg"

Ident -> [a-zA-Z] [a-zA-Z0-9_]:*
     # | ("." Name):+  # namespaces used in k @Dave should be in syntax grammar 

Name -> "`" [a-zA-Z] [a-zA-Z0-9_]:*

Digit -> [0-9]

Number  -> Digit:+ # integer
        | Digit:* "." Digit:+ # decimal
        | "0N"i | "0W"i # extreme values Null Int, Float, OutOfRange Int, Float
        # | Number Type:? # @Dave should be in syntax grammar

Datetime -> Digit:+ "." Digit:+ "." Digit:+ # date
        | Digit+ ":" Digit+ ":" Digit+ ("." Digit:+):? # time
        | Digit:+ "." Digit:+ "." Digit:+ "T" Digit+ ":" Digit+ ":" Digit+ ("." Digit:+):? # datetime

Type    -> "b" # Boolean
         | "c" # charactter
         | "d" # date
         | "e" # float
         | "f" # double
         | "g" # interge byte unsigned
         | "h" # integer 2 bytes unsigned
         | "i" # 4 integer byte unsigned
         | "j" # 8 integer byte signed
         | "n" # name (symbol)
         | "s" # time seconds
         | "S" # datetime seconds
         | "t" # time millis
         | "T" # date time millis
         | "u" # time micros
         | "U" # datetime micros
         | "v" # time nanos
         | "V" # datetime nanos
