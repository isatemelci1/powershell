# Understanding the scope of variables

if($i -ne 10)
{
    'The value of i is not equal to 10'
}
else {
    'The value of i is equal to 10'
}

if($i -eq $null)
{
    'i is null'
}

$i=20
if($i -ne 10)
{
    'The value of i is not equal to 10'
}
else {
    $i=10
    'The value of i is equal to 10'
}

$i=20
if($i -ne 10)
{
    'The value of i is not equal to 10'
    $i=30
}
else {
    $i=10
    'The value of i is equal to 10'
}

