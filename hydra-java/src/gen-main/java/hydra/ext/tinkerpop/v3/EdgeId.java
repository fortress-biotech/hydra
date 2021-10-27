package hydra.ext.tinkerpop.v3;

import hydra.core.AtomicValue;

/**
 * An atomic value representing an edge id
 */
public class EdgeId {
  public final hydra.core.AtomicValue atomicValue;
  
  /**
   * Constructs an immutable EdgeId object
   */
  public EdgeId(hydra.core.AtomicValue atomicValue) {
    this.atomicValue = atomicValue;
  }
  
  @Override
  public boolean equals(Object other) {
    if (!(other instanceof EdgeId)) {
        return false;
    }
    EdgeId o = (EdgeId) other;
    return atomicValue.equals(o.atomicValue);
  }
  
  @Override
  public int hashCode() {
    return 2 * atomicValue.hashCode();
  }
}
