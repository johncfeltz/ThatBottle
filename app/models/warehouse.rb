#########################################################################################################
#
# Project:  ThatBottle
# File:     app/models/warehouse.rb
# Version:  Beta 2
# Date:     24 July 2008
#
#
# Copyright 2008 by John Christoph Feltz; all rights reserved.
#
#########################################################################################################
#
# Definition and extension for Warehouse class, plus relationships to other classes.
# Rails automatically associates this with the DB table 'warehouses'
#
#########################################################################################################

class Warehouse < ActiveRecord::Base

# Data model relationships
  belongs_to :user
  belongs_to :warehousetype
  has_and_belongs_to_many :wines


end
