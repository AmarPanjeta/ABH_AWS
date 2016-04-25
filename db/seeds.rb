# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Image.create([{name:"Ubuntu Server 14.04 LTS",image_id:"ami-9dbea4fc",provider:"AWS"},
  {name:"Microsoft Windows Server 2008 Base - 64 bit" ,image_id:"ami-4814fb28",provider:"AWS"},
  {name:"Amazon Linux AMI 2016.03.0",image_id:"ami-792bc219",provider:"AWS"},
  {name:"SUSE Linux Enterprise Server 11 SP4 ",image_id:"",provider:"AWS"}])
