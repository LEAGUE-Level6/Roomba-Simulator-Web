import java.util.ArrayList;

public class Stack<E> {
   ArrayList<E> list = new ArrayList<E>();
   
   public E push(E item) {
     list.add(item);
     return item;
   }
   
   public E pop() { 
     if(!isEmpty())
       return list.remove(list.size()-1);
      println("EmptyStackException");
      return null;
   }
   
   public E peek() {
     return list.get(list.size()-1);
   }
   
   public boolean isEmpty(){
     return list.isEmpty();
   }
   
   public int search(Object o) {
      return (list.contains(o)) ? list.size() - list.lastIndexOf(o) : -1;
   }
   
}