module Hydra.Impl.Haskell.Sources.Graph where

import Hydra.Impl.Haskell.Sources.Core

import Hydra.Core
import Hydra.Evaluation
import Hydra.Graph
import Hydra.Impl.Haskell.Dsl.Types as Types
import Hydra.Impl.Haskell.Dsl.Standard


hydraGraphModule = Module hydraGraph [hydraCoreModule]

-- Note: here, the element namespace doubles as a graph name
hydraGraphName = "hydra/graph"

hydraGraph :: Graph Meta
hydraGraph = Graph hydraGraphName elements (const True) hydraCoreName
  where
    core = nominal . qualify hydraCoreName
    graph = nominal . qualify hydraGraphName
    def = datatype hydraGraphName
    elements = [

      def "Element"
        "A graph element, having a name, data term (value), and schema term (type)" $
        universal "m" $ record [
          field "name" $ core "Name",
          field "schema" $ universal "m" $ core "Data",
          field "data" $ universal "m" $ core "Data"],

      def "Graph"
        ("A graph, or set of legal terms combined with a set of elements over those terms, as well as another graph,"
          ++ " called the schema graph") $
        universal "m" $ record [
          field "name" $ graph "GraphName",
          field "elements" $ list $ universal "m" $ graph "Element",
          field "dataTerms" $ function (universal "m" $ core "Data") boolean,
          field "schemaGraph" $ graph "GraphName"],

      def "GraphName"
        "A unique identifier for a graph within a graph set"
        string,

      def "GraphSet"
        "A collection of graphs with a distinguished root graph" $
        universal "m" $ record [
          field "graphs" $ Types.map (graph "GraphName") (universal "m" $ graph "Graph"),
          field "root" $ graph "GraphName"],

     def "Module"
       "A logical collection of elements; a graph subset with dependencies on zero or more other subsets" $
       universal "m" $ record [
         field "graph" $ universal "m" $ graph "Graph",
         field "imports" $ list $ universal "m" $ graph "Module"]]
