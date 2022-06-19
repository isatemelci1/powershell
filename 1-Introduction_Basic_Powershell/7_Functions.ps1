# Here we are displaying a simple function

function Get-Appversion {
    $PSVersionTable    
}

# We are calling the function
Get-Appversion

# The function is being defined with two parameters
function Add-Integers([int]$x, [int]$y)
{
    'The sum of the Integers is ' +($x+$y)
}

# We are calling the function and passing in the required values
Add-Integers 10 20

# We can also define an object as a parameter to the function
function Get-Course
{
    param(
        [Object[]] $CourseList
    )

    foreach($Course in $CourseList)
{
    $Course.Id
    $Course.Name
    $Course.Rating
}
}

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


Get-Course $CourseList