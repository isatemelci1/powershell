# Here we are defining two vriables and assigning Integer values to the variables

$x=9
$y=18

# Here we are displaying the values assigned to the variables

$x
$y

# We can also add some string statements when displaying the values

'The value of x is ' + $x
'The value of y is ' + $y

# We can also perform substitution of variable values

"The value of x is $x"
"The value of y is $y"

# We can also perfom operations on the values defined in variables

$z=$x+$y
$z

# We can also define variables that hold string values

$ExampleName="Azure PowerShell"
"The name of this variable is $ExampleName"

# We can also get the data types of values assigned to variables

$x.GetType()
$ExampleName.GetType()