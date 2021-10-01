{-# LANGUAGE DeriveGeneric #-}
module Hydra.Graph
  ( Element(..)
  , Graph(..)
  , GraphName
  , GraphSet(..)
  , _Element
  , _Element_data
  , _Element_name
  , _Element_schema
  , _Graph
  , _GraphName
  , _GraphSet
  , _GraphSet_graphs
  , _GraphSet_root
  , _Graph_dataTerms
  , _Graph_elements
  , _Graph_name
  , _Graph_schemaGraph
  ) where

import GHC.Generics (Generic)
import Data.Int
import Data.Map
import Data.Set
import Hydra.Core

-- | A graph element, having a name, data term (value), and schema term (type)
data Element
  = Element
    -- | @type hydra/core.Name
    { elementName :: Name
    -- | @type hydra/core.Term
    , elementSchema :: Term
    -- | @type hydra/core.Term
    , elementData :: Term } deriving (Eq, Generic, Ord, Read, Show)

{-| A graph, or set of legal terms combined with a set of elements over those
    terms, as well as another graph, called the
    schema graph -}
data Graph
  = Graph
    -- | @type hydra/graph.GraphName
    { graphName :: GraphName
    -- | @type list: hydra/graph.Element
    , graphElements :: [Element]
    {-| @type function:
                from:
                - hydra/core.Term
                to: boolean -}
    , graphDataTerms :: Term -> Bool
    {-| A reference to this graph's schema graph within the provided graph set
        
        @type hydra/graph.GraphName -}
    , graphSchemaGraph :: GraphName }

{-| A unique identifier for a graph within a graph set
    
    @type string -}
type GraphName = String

-- | A collection of graphs with a distinguished root graph
data GraphSet
  = GraphSet
    {-| @type map:
                keys: hydra/graph.GraphName
                values: hydra/graph.Graph -}
    { graphSetGraphs :: (Map GraphName Graph)
    {-| The focal graph of this set; 'the' graph. This root graph's schema graph,
        the second-degree schema graph, etc. are
        also provided as non-root graphs.
        
        @type hydra/graph.GraphName -}
    , graphSetRoot :: GraphName }

_Element = "hydra/graph.Element" :: String
_Element_data = "data" :: String
_Element_name = "name" :: String
_Element_schema = "schema" :: String
_Graph = "hydra/graph.Graph" :: String
_GraphName = "hydra/graph.GraphName" :: String
_GraphSet = "hydra/graph.GraphSet" :: String
_GraphSet_graphs = "graphs" :: String
_GraphSet_root = "root" :: String
_Graph_dataTerms = "dataTerms" :: String
_Graph_elements = "elements" :: String
_Graph_name = "name" :: String
_Graph_schemaGraph = "schemaGraph" :: String