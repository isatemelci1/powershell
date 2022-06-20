 <#
Command Reference

1. Get-AzVMImagePublisher
https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvmimagepublisher?view=azps-7.3.0

2. Get-AzVMImageOffer
https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvmimageoffer?view=azps-7.3.0

3.  Get-AzVMImageSku
https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvmimagesku?view=azps-7.3.0

4. Get-AzVMImage
https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvmimage?view=azps-7.3.0

#>
 
 # Publisher - This refers to the organization that created the image
 # Offer - This is the group name of related images
 # SKU - An instance of a particular offer
 # Version - The Version of the Image SKU

 # First we can list the images in a particular location

 $Location="North Europe"
 
 Get-AzVMImagePublisher -Location $Location

 # Selecting a particular publisher
 $PublisherName ="Canonical"

 $Publisher=Get-AzVMImagePublisher -Location $Location `
 | Where-Object {$_.PublisherName -eq  $PublisherName}

# Next we can see the different offers

Get-AzVMImageOffer -Location $Location -PublisherName $Publisher.PublisherName


 # Selecting a particular offer

 $OfferName="UbuntuServer"
 $Offer=Get-AzVMImageOffer -Location $Location -PublisherName $Publisher.PublisherName `
 | Where-Object {$_.Offer -eq $OfferName}


 # Next we can see the different SKUs

 Get-AzVMImageSku -Location $Location -PublisherName $Publisher.PublisherName `
 -Offer $Offer.Offer

 # If you want to get a particular SKU
 $SkuName="18.04-LTS"

 $Sku= Get-AzVMImageSku -Location $Location -PublisherName $Publisher.PublisherName `
 -Offer $Offer.Offer | Where-Object {$_.Skus -eq $SkuName}

 # Finally you can see the versions for the Sku

 $Image=Get-AzVMImage -Location $Location -PublisherName $Publisher.PublisherName `
 -Offer $Offer.Offer -Sku $Sku.Skus