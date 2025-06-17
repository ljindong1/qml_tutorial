#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QFile>
#include <QJsonDocument>
#include <QJsonObject>

QString loadTargetQml()
{
    QFile file("config/test_config.json");
    if (!file.open(QIODevice::ReadOnly))
        return "";
    QJsonDocument doc = QJsonDocument::fromJson(file.readAll());
    return doc["mainQml"].toString();
}

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    QString qmlPath = loadTargetQml();
    engine.load(QUrl::fromLocalFile(qmlPath));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
