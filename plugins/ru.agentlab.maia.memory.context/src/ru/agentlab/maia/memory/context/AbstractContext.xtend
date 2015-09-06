package ru.agentlab.maia.memory.context

import java.util.Collection
import java.util.HashSet
import java.util.Set
import java.util.UUID
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.memory.IMaiaContext

@Accessors
abstract class AbstractContext implements IMaiaContext {

	val String uuid = UUID.randomUUID.toString

	var volatile IMaiaContext parent

	val Collection<IMaiaContext> childs = new HashSet

	/**
	 * 
	 * @NotNull
	 */
	override get(String name) {
		if (name == null) {
			throw new NullPointerException
		}
		if (keySet.contains(name)) {
			return doGetLocal(name)
		} else {
			if (getParent != null) {
				return getParent.get(name)
			} else {
				return null
			}
		}
	}

	override <T> get(Class<T> clazz) {
		if (clazz == null) {
			throw new NullPointerException
		}
		if (keySet.contains(clazz.name)) {
			return doGetLocal(clazz)
		} else {
			if (getParent != null) {
				return getParent.get(clazz)
			} else {
				return null
			}
		}
	}

	override getLocal(String name) {
		if (name == null) {
			throw new NullPointerException
		}
		return doGetLocal(name)
	}

	override <T> getLocal(Class<T> clazz) {
		if (clazz == null) {
			throw new NullPointerException
		}
		return doGetLocal(clazz)
	}

	override remove(String name) {
		if (name == null) {
			throw new NullPointerException
		}
		doRemoveLocal(name)
	}

	override remove(Class<?> clazz) {
		if (clazz == null) {
			throw new NullPointerException
		}
		doRemoveLocal(clazz)
	}

	override <T> set(String name, T value) {
		if (name == null) {
			throw new NullPointerException
		}
		try {
			val Class<? super T> clazz = Class.forName(name) as Class<? super T>
			doSetLocal(clazz, value)
		} catch (ClassNotFoundException e) {
			doSetLocal(name, value)
		} catch (ClassCastException e) {
			doSetLocal(name, value)
		}
	}

	override <T> set(Class<T> clazz, T value) {
		if (clazz == null) {
			throw new NullPointerException
		}
		doSetLocal(clazz, value)
	}
	
	override toString() {
		uuid
	}

	override Set<String> getKeySet() {
		return doGetKeySet
	}

	override addChild(IMaiaContext child) {
		childs += child
	}

	override removeChild(IMaiaContext child) {
		childs -= child
	}

	def Object doGetLocal(String name)

	def <T> T doGetLocal(Class<T> clazz)

	def void doSetLocal(String name, Object value)

	def <T> void doSetLocal(Class<T> clazz, T value)

	def Object doRemoveLocal(String name)

	def <T> T doRemoveLocal(Class<T> clazz)

	def Set<String> doGetKeySet()

}