$NumberOfVideos=30

# Here we are looking at the working of the if statement

if($NumberOfVideos -ge 20)
{
    "Greater or equal to 20"
}
else {
    "Less than 20"
}

# Here we are looking at the working of the while statement

$i=1
while($i -le 10)
{
    $i
    ++$i
}

# Here we are looking at the working of the for statement

for($i=1;$i -le 10;++$i)
{
    $i
}

# Here we are looking at the working of the foreach statement

$CourseVideos='Introduction','Installation','Variables'
foreach($Course in $CourseVideos)
{
    $Course
}

# We can also go through an entire array collection via the use of the foreach statement

$CourseList=@(
    [PSCustomObject]@{
        Id = 1
        Name ='AZ-104 Azure Administrator'
        Rating = 4.7
    },
    [PSCustomObject]@{
        Id = 2
        Name ='AZ-305 Azure Architect Design'
        Rating = 4.8
    },
    [PSCustomObject]@{
        Id = 3
        Name ='AZ-500 Azure Security'
        Rating = 4.9
    }
)

foreach($Course in $CourseList)
{
    $Course.Id
    $Course.Name
    $Course.Rating
}