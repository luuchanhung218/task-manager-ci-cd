
import unittest
from todo import Task, TaskPool


class TestTaskPool(unittest.TestCase):

    def setUp(self):
        self.pool = TaskPool()

    def test_add_task(self):
        self.pool.add_task(Task("New Task"))
        self.assertEqual(len(self.pool.tasks), 1)

    def test_get_open_tasks(self):
        self.pool.populate()
        tasks = self.pool.get_open_tasks()

        self.assertEqual(len(tasks), 3)
        self.assertTrue(
            all(task.status == "ToDo" for task in tasks)
        )

    def test_get_done_tasks(self):
        self.pool.populate()
        tasks = self.pool.get_done_tasks()

        self.assertEqual(len(tasks), 3)
        self.assertTrue(
            all(task.status == "Done" for task in tasks)
        )


if __name__ == "__main__":
    unittest.main(verbosity=2)
