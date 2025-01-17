module Hydra.Ext.Json.Json where

import qualified Hydra.Core as Core
import Data.Map
import Data.Set

-- A numeric value
data Number 
  = Number {
    numberInteger :: Integer,
    numberFraction :: Integer,
    numberExponent :: Integer}
  deriving (Eq, Ord, Read, Show)

_Number = (Core.Name "hydra/ext/json/json.Number")

_Number_integer = (Core.FieldName "integer")

_Number_fraction = (Core.FieldName "fraction")

_Number_exponent = (Core.FieldName "exponent")

-- A JSON value
data Value 
  = ValueArray [Value]
  | ValueBoolean Bool
  | ValueNull 
  | ValueNumber Number
  | ValueObject (Map String Value)
  | ValueString String
  deriving (Eq, Ord, Read, Show)

_Value = (Core.Name "hydra/ext/json/json.Value")

_Value_array = (Core.FieldName "array")

_Value_boolean = (Core.FieldName "boolean")

_Value_null = (Core.FieldName "null")

_Value_number = (Core.FieldName "number")

_Value_object = (Core.FieldName "object")

_Value_string = (Core.FieldName "string")