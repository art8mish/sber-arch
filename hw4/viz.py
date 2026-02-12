import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

PIC_PATH = "pics"
df = pd.read_csv("data.csv")

# Вычисляем метрики
df["Hit_Rate"] = df["HIT"] / df["ACCESS"] * 100
df["Cache_Size_Bytes"] = df["Sets"] * df["Ways"] * 64 / 1024
df["Point_Label"] = "S=" + df["Sets"].astype(str) + ", W=" + df["Ways"].astype(str)

configs = ['lru_no_prefetch', 'ship_no_prefetch', 'ship_spp_dev_pf']
labels = {
    'lru_no_prefetch': 'LRU No Prefetch',
    'ship_no_prefetch': 'SHIP No Prefetch',
    'ship_spp_dev_pf': 'SHIP + SPP Dev Prefetch'
}

traces = df['trace'].unique()

# Минимальное допустимое расстояние между точками (в данных-координатах)
MIN_DISTANCE = {
    'x': 2,   # Cache size diff threshold (bytes)
    'y': 0.5      # Hit rate diff threshold (%)
}

for trace in traces:
    data_trace = df[df['trace'] == trace]
    plt.figure(figsize=(12, 7))

    all_points = []

    for config in configs:
        subset = data_trace[data_trace['config'] == config]
        sizes = subset['Cache_Size_Bytes']
        hit_rate = subset['Hit_Rate']
        labels_point = subset['Point_Label']

        plt.plot(sizes, hit_rate, marker='o', label=labels[config])

        for x, y, txt in zip(sizes, hit_rate, labels_point):
            all_points.append((x, y, txt))

    # Фильтруем точки, оставляем только "достаточно удалённые"
    filtered_points = []
    for point in all_points:
        x_new, y_new, txt_new = point
        too_close = False
        for (x_old, y_old, _) in filtered_points:
            if abs(x_new - x_old) < MIN_DISTANCE['x'] and abs(y_new - y_old) < MIN_DISTANCE['y']:
                too_close = True
                break
        if not too_close:
            filtered_points.append(point)

    # Подписываем только отфильтрованные точки
    for x, y, txt in filtered_points:
        plt.text(x, y, txt, fontsize=8, ha='right', va='bottom')

    plt.title(f'L2 Hit Rate vs Cache Size — {trace}')
    plt.xlabel('Cache Size (Kb)')
    plt.ylabel('Hit Rate (%)')
    plt.grid(True)
    plt.legend()
    plt.xticks(data_trace['Cache_Size_Bytes'].unique())  # Только уникальные размеры
    plt.tight_layout()
    plt.savefig(f"{PIC_PATH}/{trace}_l2_hit_rate_with_filtered_labels.png")