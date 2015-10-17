package ru.agentlab.maia.task.parallel

import java.util.ArrayList
import ru.agentlab.maia.task.ITask
import ru.agentlab.maia.task.OrderedTaskScheduler

/**
 * <p>
 * Parallel implementation of {@link IExecutionScheduler}.
 * Execute until all nodes are performed.  
 * Select child nodes in order of adding.
 * <p>Default policies:</p><ul>
 * <li>When any child become {@link State#BLOCKED BLOCKED} then 
 * scheduler skip it and select next;</li>
 * <li>When any child become {@link State#FAILED FAILED} then 
 * scheduler skip it and select next;</li>
 * <li>When any child become {@link State#SUCCESS SUCCESS} then 
 * scheduler scheduling to next child;</li>
 * <li>When all child nodes are executed successfully then 
 * scheduler become {@link State#SUCCESS SUCCESS};</li>
 * </ul>
 * 
 * @author <a href='shishkindimon@gmail.com'>Shishkin Dmitriy</a> - Initial contribution.
 */
class ParallelTaskScheduler extends OrderedTaskScheduler {

	val protected blockedSubtasks = new ArrayList<ITask>

	val protected terminatedSubtasks = new ArrayList<ITask>

	override getRetriesLimit() {
		return RETRIES_INFINITE
	}

	override notifySubtaskBlocked() {
		blockedSubtasks += subtasks.remove(index)
		if (subtasks.empty) {
			state = State.BLOCKED
		}
	}

	override notifySubtaskSuccess() {
		terminatedSubtasks += subtasks.remove(index)
		if (subtasks.empty) {
			state = State.SUCCESS
		}
	}

	override notifySubtaskFailed() {
		state = State.FAILED
	}

	override notifySubtaskWorking() {
		schedule()
	}

	override notifySubtaskReady(ITask node) {
//		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	override protected internalSchedule() {
		index = (index + 1) % subtasks.size
	}

}