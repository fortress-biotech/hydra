package hydra.ext.tinkerpop.v3;

import hydra.core.AtomicType;

public abstract class Type {
  private Type() {}
  
  public abstract <R> R accept(Visitor<R> visitor) ;
  
  /**
   * An interface for applying a function to a Type according to its variant (subclass)
   */
  public interface Visitor<R> {
    R visit(Atomic instance) ;
    
    R visit(Collection instance) ;
    
    R visit(Record instance) ;
  }
  
  /**
   * An interface for applying a function to a Type according to its variant (subclass). If a visit() method for a
   * particular variant is not implemented, a default method is used instead.
   */
  public interface PartialVisitor<R> extends Visitor<R> {
    default R otherwise(Type instance) {
      throw new IllegalStateException("Non-exhaustive patterns when matching: " + instance);
    }
    
    @Override
    default R visit(Atomic instance) {
      return otherwise(instance);
    }
    
    @Override
    default R visit(Collection instance) {
      return otherwise(instance);
    }
    
    @Override
    default R visit(Record instance) {
      return otherwise(instance);
    }
  }
  
  /**
   * @type hydra/core.AtomicType
   */
  public static final class Atomic extends Type {
    public final AtomicType atomic;
    
    /**
     * Constructs an immutable Atomic object
     */
    public Atomic(AtomicType atomic) {
      this.atomic = atomic;
    }
    
    @Override
    public <R> R accept(Visitor<R> visitor) {
      return visitor.visit(this);
    }
    
    @Override
    public boolean equals(Object other) {
      if (!(other instanceof Atomic)) {
          return false;
      }
      Atomic o = (Atomic) other;
      return atomic.equals(o.atomic);
    }
    
    @Override
    public int hashCode() {
      return 2 * atomic.hashCode();
    }
  }
  
  /**
   * @type hydra/ext/tinkerpop/v3.CollectionType
   */
  public static final class Collection extends Type {
    public final CollectionType collection;
    
    /**
     * Constructs an immutable Collection object
     */
    public Collection(CollectionType collection) {
      this.collection = collection;
    }
    
    @Override
    public <R> R accept(Visitor<R> visitor) {
      return visitor.visit(this);
    }
    
    @Override
    public boolean equals(Object other) {
      if (!(other instanceof Collection)) {
          return false;
      }
      Collection o = (Collection) other;
      return collection.equals(o.collection);
    }
    
    @Override
    public int hashCode() {
      return 2 * collection.hashCode();
    }
  }
  
  /**
   * @type list: hydra/ext/tinkerpop/v3.PropertyType
   */
  public static final class Record extends Type {
    public final java.util.List<PropertyType> recordEsc;
    
    /**
     * Constructs an immutable Record object
     */
    public Record(java.util.List<PropertyType> recordEsc) {
      this.recordEsc = recordEsc;
    }
    
    @Override
    public <R> R accept(Visitor<R> visitor) {
      return visitor.visit(this);
    }
    
    @Override
    public boolean equals(Object other) {
      if (!(other instanceof Record)) {
          return false;
      }
      Record o = (Record) other;
      return recordEsc.equals(o.recordEsc);
    }
    
    @Override
    public int hashCode() {
      return 2 * recordEsc.hashCode();
    }
  }
}
