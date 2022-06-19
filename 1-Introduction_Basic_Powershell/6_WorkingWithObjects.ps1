
# Here we are defining a collection of mobile objects

$Mobiles=@(
[PSCustomObject]@{
    Brand  = "Samsung"
    Model="Galaxy S22 Ultra"
    Storage=@("128GB","256GB","512GB")
    Colors=@("Burgundy","Phantom Black","Green")
    Defaultapps=@(
        @{
            Name="Assist App"
            Status="Installed"
            Version=1.0
        },
        @{
            Name="Browser App"
            Status="Installed"
            Version=2.0
        }
    )
},
[PSCustomObject]@{
    Brand  = "Samsung"
    Model="Galaxy S22"
    Storage=@("128GB","256GB")
    Colors=@("Burgundy","Phantom Black","Pink Gold")
    Defaultapps=@(
        @{
            Name="Assist App"
            Status="Installed"
            Version=1.0
        },
        @{
            Name="Browser App"
            Status="Installed"
            Version=2.0
        }
    )
}
)

# We can display the entire Mobile collection
$Mobiles

# Or just display the first object in the collection
$Mobiles[0]

# We want to get the object where the Model is Galaxy S22
# Also we want to only select certain properties of the object
$Mobiles | Where-Object {$_.Model -eq "Galaxy S22"}
| Select-Object -Property Model,Storage

# We want to access the storage property here
$Mobiles[0].Storage[0]

# We want to access the Defaultapps property here
$Mobiles[0].Defaultapps.Item(0)

# Using a foreach statement to go through each element in the Defaultapps property
foreach($app in $Mobiles[0].Defaultapps)
{
    $app.Version
    $app.Name
    $app.Status
}