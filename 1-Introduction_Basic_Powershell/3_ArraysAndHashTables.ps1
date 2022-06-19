# Here we are creating an array of string-based values

$CourseVideos='Introduction','Installation','Variables'

# We can display the entire array of string values
$CourseVideos

# Here we are defining an array of Integer values
$CourseNumbers=1,2,3

# Here we are displaying the array of Integer values
$CourseNumbers

# Another way of declaring the array
$CourseVideos_1=@(
    'Introduction'
    'Installation'
    'Variables'
)

# Displaying the array

$CourseVideos_1

# Accessing an array value via the use of an Index number
$CourseVideos_1[0]

# We can also change the value of an array element 
$CourseVideos_1[1]='Configuration'

$CourseVideos_1

# Here we are defining a hash table

 $ServerNames=@{
     Development='Server01'
     Testing='Server02'
     Production='Server03'     
 }

# How we can access a particular element of the hash table 
 $ServerNames['Development']
 $ServerNames.Development

# We can also add elements to the hash table 
 $ServerNames.Add('QA','Server04')
 $ServerNames